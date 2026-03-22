// js/api.js
.pragma library

var openEdXAPI = {
    baseUrl: "https://courses.edx.org",
    token: null,

    setToken: function(t) { this.token = t },

    _request: function(method, endpoint, data) {
        return new Promise(function(resolve, reject) {
            var xhr = new XMLHttpRequest()
            xhr.open(method, openEdXAPI.baseUrl + endpoint)
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status >= 200 && xhr.status < 300) {
                        try { resolve(JSON.parse(xhr.responseText)) } catch(e) { resolve(xhr.responseText) }
                    } else {
                        reject({status: xhr.status, body: xhr.responseText})
                    }
                }
            }
            if (openEdXAPI.token) xhr.setRequestHeader("Authorization", "Bearer " + openEdXAPI.token)
            if (data) {
                xhr.setRequestHeader("Content-Type", "application/json")
                xhr.send(JSON.stringify(data))
            } else xhr.send()
        })
    },

    // Example: get courses (adjust endpoint for your Open edX instance)
    getCourses: function() { return this._request("GET", "/api/courses/v1/courses/") },

    // more endpoints: enrollments, course content, progress, etc.
}

