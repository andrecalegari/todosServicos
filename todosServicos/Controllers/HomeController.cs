using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace todosServicos.Controllers
{
    
    public class HomeController : Controller
    {
        public ActionResult Index(int? idServico)
        {
            idServico = idServico == null ? 0 : idServico;

            TempData["idServico"] = idServico;
            
            string nomeServidor = "";

            if (HttpContext.Request.Url.Host.Equals("localhost") && HttpContext.Request.Url.Port.ToString() != "" && HttpContext.Request.Url.Port.ToString() != "80")
                nomeServidor = HttpContext.Request.Url.Host + ((HttpContext.Request.Url.Port > 0) ? ":" + HttpContext.Request.Url.Port : "");
            else
                nomeServidor = HttpContext.Request.Url.Host + (HttpContext.Request.Url.AbsoluteUri.IndexOf("Homologacao") >= 0 ? "/HomologacaoWMS.Net" : "/WMS.Net");

            // cria cookies para serem usados
            //Response.Cookies["nome_servidor"].Value = nomeServidor;

            Session["nomeServidor"] = nomeServidor;

            return View();
        }

        public ActionResult cadastrarPrestador()
        {
            TempData["idServico"] = 0;
            //ViewBag.Message = "Your application description page.";

            return View();
        }

        [HttpPost]
        public ActionResult cadastrarPrestador(string nome, string cpf, string rua, string bairro, string cidade, string uf, string numero, string email, string senha, string cep, string telefone, string[] idServico)
        {
            db_servicosEntities db = new db_servicosEntities();

            TB_Usuario usuario = new TB_Usuario();
            TB_PerfilUsuario perfilUsuario = new TB_PerfilUsuario();
            TB_LocalizacaoUsuario localizacaoUsuario = new TB_LocalizacaoUsuario();
            TB_ServicoUsuario servicoUsuario = new TB_ServicoUsuario();

            MD5 md5Hasher = MD5.Create();

            string login = nome;

            // Convert the input string to a byte array and compute the hash.
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(senha));
            
            try
            {
                using (db_servicosEntities context = new db_servicosEntities())
                {
                    usuario.Login = login;
                    usuario.Senha = data;
                    usuario.flAtivo = true;
                    usuario.dtAtivacao = DateTime.Today;
                    usuario.dtCriacao = DateTime.Today;

                    context.TB_Usuario.Add(usuario);
                    context.SaveChanges();

                    int idUsuario = usuario.idUsuario;

                    localizacaoUsuario.idUsuario = idUsuario;
                    localizacaoUsuario.latitude = 0;
                    localizacaoUsuario.longitude = 0;

                    context.TB_LocalizacaoUsuario.Add(localizacaoUsuario);
                    context.SaveChanges();

                    perfilUsuario.idUsuario     = idUsuario;
                    perfilUsuario.nome          = nome;
                    perfilUsuario.cpf           = cpf;
                    perfilUsuario.email         = email;
                    perfilUsuario.endereco      = rua;
                    perfilUsuario.numero        = numero;
                    perfilUsuario.complemento   = "";
                    perfilUsuario.bairro        = bairro;
                    perfilUsuario.cep           = cep;
                    perfilUsuario.idEstado      = 1; //ALTERAR DEPOIS
                    perfilUsuario.idCidade      = 1; //ALTERAR DEPOIS
                    perfilUsuario.tipoPerfil    = "Servico";

                    context.TB_PerfilUsuario.Add(perfilUsuario);
                    context.SaveChanges();

                    foreach (var item in idServico) { 
                        servicoUsuario.idUsuario = idUsuario;
                        servicoUsuario.idServico = Convert.ToInt32(item);

                        context.TB_ServicoUsuario.Add(servicoUsuario);
                        context.SaveChanges();
                    }
                }

                //return true;
            }
            catch (Exception e)
            {
                //return false;
            }

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public JsonResult BuscarServicoPorLocalizacao(int idServico, double latitude, double longitude)
        {
            db_servicosEntities db = new db_servicosEntities();

            List<STP_LST_BuscarServicoPorLocalizacao_Result> lstLocalizacao = new List<STP_LST_BuscarServicoPorLocalizacao_Result>();
            
            using (db_servicosEntities context = new db_servicosEntities())
            {

                var query = context.STP_LST_BuscarServicoPorLocalizacao(latitude, longitude, idServico).ToList();

                foreach (var item in query)
                {
                    STP_LST_BuscarServicoPorLocalizacao_Result localizacaoServico = new STP_LST_BuscarServicoPorLocalizacao_Result();

                    localizacaoServico.latitude = item.latitude;
                    localizacaoServico.longitude = item.longitude;
                    localizacaoServico.idUsuario = item.idUsuario;
                    localizacaoServico.nome = item.nome;
                    localizacaoServico.sigla = item.sigla;
                    localizacaoServico.cidade = item.cidade;
                    localizacaoServico.distancia = Convert.ToInt32(item.distancia);
                    localizacaoServico.imagem = item.imagem;

                    lstLocalizacao.Add(localizacaoServico);
                }
            }

            return Json(lstLocalizacao);
        }

        public JsonResult ListarServico(string idServico)
        {
            db_servicosEntities db = new db_servicosEntities();
            List<TB_Servico> lstServico = new List<TB_Servico>();

            using (db_servicosEntities context = new db_servicosEntities())
            {
                try { 
                    var query = context.TB_Servico.Where(x => x.flAtivo == true);

                    foreach (var item in query)
                    {
                        TB_Servico servico = new TB_Servico();

                        servico.idServico = item.idServico;
                        servico.descricao = item.descricao;
                        servico.Imagem = item.Imagem;

                        lstServico.Add(servico);
                    }
                }
                catch (Exception e){
                    Exception erro = e.InnerException;
                }
            }

            return Json(lstServico);
        }
        
        public JsonResult SolicitarServico(int idUsuarioDestino, int idServico)
        {
            if(Request.IsAuthenticated == false)
            {
                return Json(0);
            }

            int idUsuario = Convert.ToInt32(Session["idUsuario"].ToString());

            TB_Solicitacao solicitacao = new TB_Solicitacao();
            TB_SolicitacaoServico solicitacaoServico = new TB_SolicitacaoServico();
            try
            {
                using (db_servicosEntities context = new db_servicosEntities())
                {
                    solicitacao.idStatus = 1;
                    solicitacao.dtCricao = DateTime.Today;
                    solicitacao.idUsuarioOrigem = idUsuario;
                    solicitacao.idUsuarioDestino = idUsuarioDestino;
                    solicitacao.dtRetirada = null;
                    solicitacao.dtRecebidoCentral = null;
                    solicitacao.dtValidacao = null;
                    solicitacao.dtEnvioDestino = null;
                    solicitacao.dtEntregue = null;
                    solicitacao.dtDevolucao = null;
                    solicitacao.idDevolucaoMotivo = null;
                    solicitacao.obsMotivoDevolucao = null;
                    solicitacao.recebidoPor = null;

                    context.TB_Solicitacao.Add(solicitacao);
                    context.SaveChanges();

                    //context.Entry(solicitacao).GetDatabaseValues();
                    int IdSolicitacao = solicitacao.idSolicitacao;

                    //var newTaskId = context.Tasks.OrderByDescending(x => x.TaskId).FirstOrDefault().TaskId;

                    solicitacaoServico.IdSolicitacao = IdSolicitacao;
                    solicitacaoServico.idServico = idServico;

                    context.TB_SolicitacaoServico.Add(solicitacaoServico);
                    context.SaveChanges();
                }

                return Json(1);
            }
            catch (Exception e)
            {
                return Json("Solicitação não concluida, por favor, tente mais tarde.");
            }
        }
    }
}