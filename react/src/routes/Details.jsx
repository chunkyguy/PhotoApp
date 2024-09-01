import { useEffect, useState } from "react";
import { Loading } from "../components/Loading";
import { PhotoTile } from "../components/PhotoTile";
import { useParams } from "react-router-dom";
import "./Details.css";

export function Details() {
  const { id } = useParams();
  const [photo, setPhoto] = useState(null);

  async function fetchData(id) {
    const response = await fetch(
      `https://jsonplaceholder.typicode.com/photos/${id}`
    );
    const content = await response.json();
    setPhoto(content);
  }

  useEffect(() => {
    fetchData(id);
  }, [id]);

  return (
    <>
      {!photo ? (
        <Loading />
      ) : (
        <ul>
          <div className="photoDetails">
            <PhotoTile title={photo.title} url={photo.url} path={".."} />
            <p>{photo.title}</p>
          </div>
        </ul>
      )}
    </>
  );
}
