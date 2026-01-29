using Microsoft.EntityFrameworkCore;
using ProductCrudApp.Data;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();




builder.Services.AddDbContext<ApplicationDbContext>(options =>
{
    Console.WriteLine("DB CONTEXT REGISTERED");
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection"));
});



var app = builder.Build();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
