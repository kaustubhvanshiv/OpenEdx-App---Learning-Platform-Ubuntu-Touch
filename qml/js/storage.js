// js/storage.js
.pragma library

var Storage = {
    storageManager: {
        getPendingSyncItems: function() {
            var raw = localStorage.getItem("openedx_pending") || "[]"
            return JSON.parse(raw)
        },
        addSyncItem: function(item) {
            var arr = this.getPendingSyncItems()
            arr.push(item)
            localStorage.setItem("openedx_pending", JSON.stringify(arr))
        },
        removeSyncItem: function(id) {
            var arr = this.getPendingSyncItems().filter(function(it){ return it.id !== id })
            localStorage.setItem("openedx_pending", JSON.stringify(arr))
        },
        getCachedCourses: function() {
            var raw = localStorage.getItem("openedx_courses") || "[]"
            return JSON.parse(raw)
        },
        setCachedCourses: function(courses) {
            localStorage.setItem("openedx_courses", JSON.stringify(courses))
        },
        clearCache: function() {
            localStorage.removeItem("openedx_courses")
            localStorage.removeItem("openedx_pending")
        }
    }
}

