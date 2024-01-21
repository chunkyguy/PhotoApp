namespace PhotoApp.Views;

public partial class DetailsPage : ContentPage
{
	public DetailsPage()
	{
		InitializeComponent();
	}

	private async void LearnMore_Clicked(object sender, EventArgs e)
	{
		await Launcher.Default.OpenAsync("https://whackylabs.com");
	}
}