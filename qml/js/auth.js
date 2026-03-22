// js/auth.js
.pragma library

var Auth = {
    authManager: {
        tokenKey: "openedx_token",
        userKey: "openedx_user",
        _token: null,
        _user: null,

        setToken: function(token) { this._token = token; localStorage.setItem(this.tokenKey, token) },
        setUser: function(user) { this._user = user; localStorage.setItem(this.userKey, JSON.stringify(user)) },

        loadStoredCredentials: function() {
            var t = localStorage.getItem(this.tokenKey)
            var u = localStorage.getItem(this.userKey)
            if (t && u) {
                this._token = t
                this._user = JSON.parse(u)
                return true
            }
            return false
        },

        getToken: function() { return this._token },
        getUser: function() { return this._user },

        login: function(username, password, server) {
            return new Promise(function(resolve, reject) {
                // simple token request example - replace with real edX token endpoint
                var xhr = new XMLHttpRequest()
                Auth.authManager.server = server || Auth.authManager.server || "https://courses.edx.org"
                var url = Auth.authManager.server + "/oauth2/access_token/" // adjust accordingly
                xhr.open("POST", url)
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var resp = JSON.parse(xhr.responseText)
                            Auth.authManager._token = resp.access_token
                            Auth.authManager._user = { username: username }
                            localStorage.setItem(Auth.authManager.tokenKey, resp.access_token)
                            localStorage.setItem(Auth.authManager.userKey, JSON.stringify(Auth.authManager._user))
                            resolve(true)
                        } else reject(new Error("Login failed: " + xhr.status))
                    }
                }
                var body = "grant_type=password&username=" + encodeURIComponent(username) + "&password=" + encodeURIComponent(password)
                xhr.send(body)
            })
        },

        logout: function() {
            localStorage.removeItem(this.tokenKey)
            localStorage.removeItem(this.userKey)
            this._token = null; this._user = null
        }
    }
}


