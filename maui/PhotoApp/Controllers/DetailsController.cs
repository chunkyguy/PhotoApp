using System.Collections.ObjectModel;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

namespace PhotoApp;

public partial class DetailsController : ObservableObject, IQueryAttributable
{
    public ObservableCollection<Photo> Photos { get; } = new();

    [ObservableProperty]
    string title;

    public DetailsController()
    {
        Title = "Details";
    }


    public void ApplyQueryAttributes(IDictionary<string, object> query)
    {
        var photo = query["Photo"] as Photo;
        Photos.Add(photo);
    }

    [RelayCommand]
    async Task GoBack()
    {
        await Shell.Current.GoToAsync("..", true);
    }
}
