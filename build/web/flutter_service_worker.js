'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "404.html": "0a27a4163254fc8fce870c8cc3a3f94f",
"assets/AssetManifest.json": "ec926ce0a0518d41864597cce3f88268",
"assets/assets/images/background4.jpg": "b00f0bb1e37dac6314b10a5a5ed3b62e",
"assets/assets/images/logo_amrita.png": "fcba65f4932e01680f421b58dd5b1a58",
"assets/assets/images/logo_bathinda.png": "ba20fada71f566342e43a15d87edfcae",
"assets/assets/images/logo_cm_live.jpeg": "9cbbbd751954ceaee3c3f45faa4029d9",
"assets/assets/images/logo_collect.jpeg": "5dc0f3d4edcaef02ab53c7d5cb968ee6",
"assets/assets/images/logo_dialkiwi.png": "650dec573e51dc62955726c2fe2527a4",
"assets/assets/images/logo_hanumangarh.jpeg": "ef416f7fece4e4a9426d37fb3112061a",
"assets/assets/images/logo_lookplanner.jpeg": "31836e3ef53a26601fc8707eac7398dc",
"assets/assets/images/logo_mercy.png": "0318c6a492f91952e50b8fe9a0feb91f",
"assets/assets/images/logo_photo_tune_plus.jpeg": "3e6d2e7af1daa5bf9a32a8936d761ff4",
"assets/assets/images/logo_she_plus.png": "fe1a98f507949cbcc90dd670d8e7ffad",
"assets/assets/images/logo_sopodely.png": "871946e7356489a33518ec6f4174d17d",
"assets/assets/images/logo_sopodely_driver.png": "fbc7b02018d09cc78749b1464a0aa032",
"assets/assets/images/profile.jpeg": "b15631d97d58ee4b89b8174b83792a71",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/images/background4.jpg": "b00f0bb1e37dac6314b10a5a5ed3b62e",
"assets/images/logo_bathinda.png": "ba20fada71f566342e43a15d87edfcae",
"assets/images/logo_cm_live.jpeg": "9cbbbd751954ceaee3c3f45faa4029d9",
"assets/images/logo_collect.jpeg": "5dc0f3d4edcaef02ab53c7d5cb968ee6",
"assets/images/logo_dialkiwi.png": "650dec573e51dc62955726c2fe2527a4",
"assets/images/logo_hanumangarh.jpeg": "ef416f7fece4e4a9426d37fb3112061a",
"assets/images/logo_lookplanner.jpeg": "31836e3ef53a26601fc8707eac7398dc",
"assets/images/logo_photo_tune_plus.jpeg": "3e6d2e7af1daa5bf9a32a8936d761ff4",
"assets/images/logo_she_plus.png": "fe1a98f507949cbcc90dd670d8e7ffad",
"assets/images/logo_sopodely.png": "871946e7356489a33518ec6f4174d17d",
"assets/images/logo_sopodely_driver.png": "fbc7b02018d09cc78749b1464a0aa032",
"assets/images/profile.jpeg": "b15631d97d58ee4b89b8174b83792a71",
"assets/NOTICES": "36090f27aea0bec01bde94790bac8997",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.png": "bd3c752e1406e478bc0bdcf9a34a1062",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "439195c709ba1d1134dc674f08e2cf1e",
"/": "439195c709ba1d1134dc674f08e2cf1e",
"main.dart.js": "fa0c75b6c246858f32d48465898be976",
"manifest.json": "75721181c830e84b9d2b33e7c2b97e0a",
"version.json": "009c9e65172e010890f7f65fde438006"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
