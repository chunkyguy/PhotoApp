using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using PhotoApp.Views;

namespace PhotoApp.Controllers;

public partial class MainController : ObservableObject
{
    [RelayCommand]
    async Task Tap()
    {
        await Shell.Current.GoToAsync(nameof(DetailsPage));
    }
}
