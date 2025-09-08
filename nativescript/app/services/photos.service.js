async function getData(url) {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Response status: ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    console.error(error.message);
    return null;
  }
}

export async function getPhotos() {
  return await getData("https://picsum.photos/v2/list?page=2");
}

export async function getPhotoById(id) {
  return await getData(`https://picsum.photos/id/${id}/info`);
}
