//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace todosServicos
{
    using System;
    using System.Collections.Generic;
    
    public partial class TB_ServicoUsuario
    {
        public int idServicoUsuario { get; set; }
        public int idServico { get; set; }
        public int idUsuario { get; set; }
    
        public virtual TB_Servico TB_Servico { get; set; }
        public virtual TB_Usuario TB_Usuario { get; set; }
    }
}
