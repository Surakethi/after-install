### Notes in action
1. Command untuk meningkatkan inotify watches di linux (case: vite.js yang tiba-tiba off saat running, ternyata kekurangan inotify watches).
```sysctl -w fs.inotify.max_user_watches=524288``` 
