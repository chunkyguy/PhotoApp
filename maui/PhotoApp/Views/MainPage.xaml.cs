using System.Diagnostics;

namespace PhotoApp;

public partial class MainPage : ContentPage
{
	public MainPage(MainController controller)
	{
		InitializeComponent();
		BindingContext = controller;
	}
}
