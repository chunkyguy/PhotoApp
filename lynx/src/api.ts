const BASE_URL = "https://picsum.photos";

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
export interface Photo {
  id: string;
  author: string;
  width: number;
  height: number;
}

const TIMEOUT_MS = 15000;

// Lynx's fetch has no timeout, and if the host's HTTP service never answers the
// promise never settles. Race it against a timer so the UI can show an error.
function withTimeout<T>(promise: Promise<T>, ms: number): Promise<T> {
  return new Promise<T>((resolve, reject) => {
    const timer = setTimeout(
      () => reject(new Error(`Request timed out after ${ms / 1000}s`)),
      ms,
    );
    promise.then(
      (value) => {
        clearTimeout(timer);
        resolve(value);
      },
      (error: unknown) => {
        clearTimeout(timer);
        reject(error);
      },
    );
  });
}

export async function fetchPhotos(): Promise<Photo[]> {
  const url = `${BASE_URL}/v2/list?page=1&limit=30`;
  const response = await withTimeout(fetch(url), TIMEOUT_MS);
  if (response.status < 200 || response.status >= 300) {
    throw new Error(`Request failed (${response.status})`);
  }
  return (await withTimeout(response.json(), TIMEOUT_MS)) as Photo[];
}

export function photoUrl(id: string, width: number, height = width): string {
  return `${BASE_URL}/id/${id}/${width}/${height}`;
}
