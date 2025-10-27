'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "618649caad74bc70e53eea485208152e",
"assets/AssetManifest.bin.json": "36eea10247210ac88360a0ebd5700e3a",
"assets/AssetManifest.json": "7fcb43dffd2a14ff4b250d1c50c141f8",
"assets/assets/images/barber1.jpeg": "b5096f687994e1d4c6c5e590db36c878",
"assets/assets/images/barber19.png": "2d71512a383da11916f6dcbe968ee2d9",
"assets/assets/images/barbr1.png": "64c28aa62c1c2d2a7a296b06603a85fc",
"assets/assets/images/barbr2.png": "a673f1332cf8df4eee71696a60e40ba4",
"assets/assets/images/barbr3.png": "1b314a678cfb6faa509eb3a76393ece3",
"assets/assets/images/barbr4.png": "d784b2557a71b8fdcb724f2def82168d",
"assets/assets/images/barbr5.png": "0a290862ebb6dea4e4f9785463a9fbe7",
"assets/assets/images/barbr6.png": "4ca6242b46d672a927a8b3f4949ea4cc",
"assets/assets/images/beard/beard1.jpeg": "5a4704a8850d8e51795fe48942468975",
"assets/assets/images/beard/beard2.webp": "84a04e458deac11bd03679a195ea3991",
"assets/assets/images/beard/beard3.jpg": "a3ecc4729bf9f5aa4ced0eb0b912bb26",
"assets/assets/images/beard/beard4.jpg": "306d1e5943fd08314b3b35afe1b8cad4",
"assets/assets/images/beard/beard5.jpg": "033992acaddd97d5697933a27d13dd9a",
"assets/assets/images/beard/beard6.jpg": "ca8afba92912af2789212fa29fce037c",
"assets/assets/images/beard/beard7.jpg": "d9bdd1c4b42d54a8ca0f20b8395876d8",
"assets/assets/images/beard/berad6.jpg": "00d7d3c7ec3727b26275a921d41b19ed",
"assets/assets/images/br2.webp": "4fc397912455544ef7ea4decd524ab53",
"assets/assets/images/brr12.png": "a70c9cdd692cf5a51cd92c9523bd2b57",
"assets/assets/images/hear/fade.webp": "6a9740373b9c598f40e20a7b0afb8505",
"assets/assets/images/hear/fade1.webp": "d9f86e2db34fcd95361dfd42e4fe1e0c",
"assets/assets/images/hear/long.jpeg": "cb19eaa2e7b33483a41296abebac83a6",
"assets/assets/images/hear/sort.jpg": "e7007617403135576fc236aaa8258536",
"assets/assets/images/hear/taper.jpg": "5a23703fbf1720b4f864c6a1cad086f3",
"assets/assets/images/hear/top1.webp": "ff42b5e5f29c5b39c26e69bb06dbdd26",
"assets/assets/images/hear/top2.jpg": "726edec1d419d885375477d8431287bc",
"assets/assets/images/hear/top3.jpg": "1bbf81c3f79f997844b06749763b61fb",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "431a05dc9bc6cc8ea6d3b029d6c8254b",
"assets/NOTICES": "379b9c6e4f0e0a5e497f32b89115e57c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "3db23a944123a6c9ed678119e3e4e11a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "bfa7a15c97fd0e0cef1edcdb78254f26",
"/": "bfa7a15c97fd0e0cef1edcdb78254f26",
"main.dart.js": "f79a56afe37cfb22257fd05b81c17cc4",
"manifest.json": "be258278f17860cd9cb377fbf469fbeb",
"version.json": "5b9de772508e4013b783bfece2fff107"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
