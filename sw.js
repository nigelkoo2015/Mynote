// Minimal service worker — required so Chrome on Android offers "Install app".
// We don't cache anything (notes are server-side and need to be fresh),
// we just pass every request through to the network.

self.addEventListener("install", (e) => { self.skipWaiting(); });
self.addEventListener("activate", (e) => { e.waitUntil(self.clients.claim()); });
self.addEventListener("fetch", (e) => { /* network passthrough */ });
