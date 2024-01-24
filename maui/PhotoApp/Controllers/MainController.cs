using System.Collections.ObjectModel;
using System.Diagnostics;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

namespace PhotoApp;

public partial class MainController : ObservableObject
{
    public ObservableCollection<Photo> Photos { get; } = new();
    PhotoService photoService;

    [ObservableProperty]
    bool isRefreshing;

    [ObservableProperty]
    [NotifyPropertyChangedFor(nameof(IsNotBusy))]
    bool isBusy;

    [ObservableProperty]
    string title;

    public bool IsNotBusy => !IsBusy;

    public MainController(PhotoService photoService)
    {
        this.photoService = photoService;
        Title = "Photos";
    }

    [RelayCommand]
    async Task Tap(Photo photo)
    {
        var navigationParameter = new Dictionary<string, object> { { "Photo", photo } };
        await Shell.Current.GoToAsync(nameof(DetailsPage), navigationParameter);
    }

    [RelayCommand]
    async Task GetPhotos()
    {
        if (IsBusy) return;

        Debug.WriteLine("[mainpage] start loading ...");
        try
        {
            IsBusy = true;
            var photos = await photoService.GetPhotos();

            Photos.Clear();

            // The default photos is a list of 5000 elements .. so we only load first few
            for (int i = 0; i < photos.Count && i < 10; i++)
                Photos.Add(photos[i]);
        }
        catch (System.Exception ex)
        {
            Debug.WriteLine($"[mainpage] err: {ex}");
            // TODO: show error UI

        }
        finally
        {
            IsBusy = false;
            IsRefreshing = false;
        }
    }
}
