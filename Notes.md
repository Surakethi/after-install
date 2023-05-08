### Notes in action
1. Command untuk meningkatkan inotify watches di linux (case: vite.js yang tiba-tiba off saat running, ternyata kekurangan inotify watches).
```sysctl -w fs.inotify.max_user_watches=524288``` 

2. Comment untuk streshing Memory (tanpa swap)
```sysctl -w vm.swappiness=1```
```sysctl -w vm.vfs_cache_pressure=50```
