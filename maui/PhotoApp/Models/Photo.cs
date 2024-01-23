using System.Text.Json.Serialization;

namespace PhotoApp;

public class Photo
{
    public int albumId { get; set; }
    public int id { get; set; }
    public string title { get; set; }
    public string url { get; set; }
    public string thumbnailUrl { get; set; }
}

[JsonSerializable(typeof(List<Photo>))]
internal sealed partial class PhotoContext : JsonSerializerContext
{
}