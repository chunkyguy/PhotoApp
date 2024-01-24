using System.Net.Http.Json;

namespace PhotoApp;

public class PhotoService
{
    HttpClient httpClient;

    public PhotoService()
    {
        httpClient = new HttpClient();
    }

    public async Task<List<Photo>> GetPhotos()
    {
        var response = await httpClient.GetAsync("https://jsonplaceholder.typicode.com/photos");
        if (response.IsSuccessStatusCode)
        {
            return await response.Content.ReadFromJsonAsync(PhotoContext.Default.ListPhoto);
        }
        return new List<Photo>();
    }
}