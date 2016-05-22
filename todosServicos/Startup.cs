using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(todosServicos.Startup))]
namespace todosServicos
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
