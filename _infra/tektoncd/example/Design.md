CronJob runs periodically, triggering a TaskRun.
TaskRun checks for the latest SHA in the repository and compares it to the previous one which was stored on a permanent PVC # which contains state.
If there was a change, TaskRun triggers a build.

- git ls-remote https://github.com/andrescosta/todo-jobico-cloud | awk '/HEAD/ {print $1}'

https://github.com/tektoncd/triggers/tree/main/examples/v1beta1/create-configmap
https://github.com/tektoncd/triggers/tree/main/examples/v1beta1/cron