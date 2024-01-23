using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

namespace PhotoApp;

public partial class DetailsController : ObservableObject
{
    [RelayCommand]
    async Task GoBack()
    {
        await Shell.Current.GoToAsync("..", true);
    }
}
