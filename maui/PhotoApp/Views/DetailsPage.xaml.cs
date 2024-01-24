namespace PhotoApp;

public partial class DetailsPage : ContentPage
{
	public DetailsPage(DetailsController controller)
	{
		InitializeComponent();
		BindingContext = controller;
	}
}
