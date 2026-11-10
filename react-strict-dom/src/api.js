const BASE_URL = "https://picsum.photos";
const TIMEOUT_MS = 15000;

// fetch() has no timeout by default; a stalled connection would leave the UI loading forever.
async function getJson(url) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), TIMEOUT_MS);
  try {
    const response = await fetch(url, { signal: controller.signal });
    if (!response.ok) throw new Error(`Request failed (${response.status})`);
    return await response.json();
  } catch (e) {
    // Check the signal rather than e.name: Expo's fetch throws a different error type on abort.
    if (controller.signal.aborted) throw new Error("Request timed out");
    throw e;
  } finally {
    clearTimeout(timer);
  }
}

/*
{
  "id": "0",
  "author": "Alejandro Escamilla",
  "width": 5000,
  "height": 3333,
  "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
  "download_url": "https://picsum.photos/id/0/5000/3333"
}
*/
export function fetchPhotos({ page = 1, limit = 30 } = {}) {
  return getJson(`${BASE_URL}/v2/list?page=${page}&limit=${limit}`);
}

export function fetchPhoto(id) {
  return getJson(`${BASE_URL}/id/${id}/info`);
}

export function photoUrl(id, width, height = width) {
  return `${BASE_URL}/id/${id}/${width}/${height}`;
}
