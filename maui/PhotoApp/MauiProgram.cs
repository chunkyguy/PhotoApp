using Microsoft.Extensions.Logging;

namespace PhotoApp;

public static class MauiProgram
{
	public static MauiApp CreateMauiApp()
	{
		var builder = MauiApp.CreateBuilder();
		builder
			.UseMauiApp<App>()
			.ConfigureFonts(fonts =>
			{
				fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
				fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
			});

#if DEBUG
		builder.Logging.AddDebug();
#endif

		builder.Services.AddSingleton<PhotoService>();

		builder.Services.AddSingleton<MainPage>();
		builder.Services.AddSingleton<MainController>();

		builder.Services.AddTransient<DetailsPage>();
		builder.Services.AddTransient<DetailsController>();

		return builder.Build();
	}
}
