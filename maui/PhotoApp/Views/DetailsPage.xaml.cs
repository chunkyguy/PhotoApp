using PhotoApp.Controllers;

namespace PhotoApp.Views;

public partial class DetailsPage : ContentPage
{
	public DetailsPage(DetailsController controller)
	{
		InitializeComponent();
		BindingContext = controller;
	}
}