# Architecture

## High level 
![Alt](docs/arch-k8s.svg)

## Data Model
```mermaid
erDiagram
  MUser ||--o{ Activity : creates
  Activity ||--o{ Media : associates
  Activity ||--o{ Label_Activity : associates
  MUser ||--o{ Label: owns
  Label ||--o{ Label_Activity : associates

  MUser {
      bigint id PK
      uuid public_id UK
      text full_name
      text mail
      timestamptz created_at
      timestamptz updated_at
  }
  Activity {
    bigint id PK
    uuid public_id UK
    text name
    text description
    text type
    text status
    text state
    text[] tags
    jsonb extra_data
    bigint muser_id FK
    timestamptz created_at
    timestamptz updated_at
  }
  
  Label {
    bigint id PK
    uuid public_id UK
    text name
    text description
    bigint muser_id FK
    timestamptz created_at
    timestamptz updated_at
  }

  Media {
    bigint id PK
    uuid public_id UK
    bigint activity_id FK
    text name
    text type
    text uri
    text description
    json extra_data
    timestamptz created_at
    timestamptz updated_at
  }
  Label_Activity {
    bigint id PK
    bigint label_id FK
    bigint activity_id FK
    timestamptz created_at
    timestamptz updated_at
  }
```


# Stack

## Activity Service
* Java 19
* Go (Improver job service)
* Spring Boot
* Spring RestDocs
* Micrometer
* Zipkin
* Loki4j
* Pyroscope
* Slf4j 
* Maven
* GSon
* JJWT


## Identity Management
* Zitadel (SSO)
  * OpenID Connect

## Database
* Postgress

## API Documentation
* Asciidoctor

## Infra
* Jobico Cloud

## Testing
* Junit 5 (Unit)
* TestContainers (Integration) 
* Gatling (Performance)

## Web Client
* React
* W3.CSS
* Babel
* Webpack
* Axios
