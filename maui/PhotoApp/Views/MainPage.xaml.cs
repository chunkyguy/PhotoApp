using PhotoApp.Controllers;

namespace PhotoApp.Views;

public partial class MainPage : ContentPage
{
	public MainPage(MainController controller)
	{
		InitializeComponent();
		BindingContext = controller;
	}
}

