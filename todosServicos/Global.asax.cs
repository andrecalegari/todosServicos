using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;

namespace todosServicos
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        // Captura do evento
        /*protected void Application_AuthenticateRequest(Object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current.User == null)
                return;

            if (!System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
                return;

            if (System.Web.HttpContext.Current.User.Identity is FormsIdentity)
            {
                var id = (FormsIdentity)System.Web.HttpContext.Current.User.Identity;

                FormsAuthenticationTicket ticket = id.Ticket;

                string userData = ticket.UserData;

                string[] roles = userData.Split(',');

                System.Web.HttpContext.Current.User = new GenericPrincipal(id, roles);
            }
        }*/

        protected void Application_PostAuthenticateRequest(Object sender, EventArgs e)
        {
            var authCookie = System.Web.HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                if (authTicket != null && !authTicket.Expired)
                {
                    var roles = authTicket.UserData.Split(',');
                    System.Web.HttpContext.Current.User = new System.Security.Principal.GenericPrincipal(new FormsIdentity(authTicket), roles);
                }
            }
        }
    }
}
