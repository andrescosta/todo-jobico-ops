package com.coeux.todo.filters;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.GenericFilterBean;

import com.coeux.todo.jwt.JwtTokenAuthenticationProvider;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class JwtTokenAuthenticationFilter extends GenericFilterBean {

    Logger log = LoggerFactory.getLogger(JwtTokenAuthenticationFilter.class);

    private JwtTokenAuthenticationProvider jwtTokenProvider = null;

    public JwtTokenAuthenticationFilter(JwtTokenAuthenticationProvider tokenProvider) {
        this.jwtTokenProvider = tokenProvider;
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain filterChain)
            throws IOException, ServletException {

        HttpServletRequest servletRequest = (HttpServletRequest) req;
        HttpServletResponse servletResponse = (HttpServletResponse) res;
        boolean unauthorized = false;
        try {
            if (jwtTokenProvider.isAuthTokenPresent(servletRequest)) {
                String token = jwtTokenProvider.getAuthToken(servletRequest);
                if (jwtTokenProvider.validateRequestToken(token)) {
                    Authentication auth = jwtTokenProvider.getAuthentication(token);
                    SecurityContext context = SecurityContextHolder.createEmptyContext();
                    context.setAuthentication(auth);
                    SecurityContextHolder.setContext(context);
                } else {
                    unauthorized = true;
                }
            }
        } catch (Exception e) {
            log.error("Error processing the JWT token.", e);
            unauthorized = true;
        }
        if (unauthorized) {
            servletResponse.setStatus(HttpStatus.UNAUTHORIZED.value());
        }
        filterChain.doFilter(req, res);
    }
}