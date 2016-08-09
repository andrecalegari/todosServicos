
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 08/01/2016 23:33:28
-- Generated from EDMX file: C:\Users\andre\OneDrive\Documentos\GitHub\todosServicos\todosServicos\EF_todosServicos.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [db_servicos];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_TB_Cidade_TB_Estado]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_Cidade] DROP CONSTRAINT [FK_TB_Cidade_TB_Estado];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_LocalizacaoUsuario_TB_Usuario]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_LocalizacaoUsuario] DROP CONSTRAINT [FK_TB_LocalizacaoUsuario_TB_Usuario];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_PerfilUsuario_TB_Cidade]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_PerfilUsuario] DROP CONSTRAINT [FK_TB_PerfilUsuario_TB_Cidade];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_PerfilUsuario_TB_Estado]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_PerfilUsuario] DROP CONSTRAINT [FK_TB_PerfilUsuario_TB_Estado];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_PerfilUsuario_TB_Usuario]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_PerfilUsuario] DROP CONSTRAINT [FK_TB_PerfilUsuario_TB_Usuario];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_ServicoUsuario_TB_Servico]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_ServicoUsuario] DROP CONSTRAINT [FK_TB_ServicoUsuario_TB_Servico];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_ServicoUsuario_TB_Usuario]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_ServicoUsuario] DROP CONSTRAINT [FK_TB_ServicoUsuario_TB_Usuario];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_Soilcitacao_TB_Soilcitacao]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_Solicitacao] DROP CONSTRAINT [FK_TB_Soilcitacao_TB_Soilcitacao];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_Soilcitacao_TB_SolicitacaoStatus]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_Solicitacao] DROP CONSTRAINT [FK_TB_Soilcitacao_TB_SolicitacaoStatus];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_SolicitacaoServico_TB_Servico]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_SolicitacaoServico] DROP CONSTRAINT [FK_TB_SolicitacaoServico_TB_Servico];
GO
IF OBJECT_ID(N'[dbo].[FK_TB_SolicitacaoServico_TB_Soilcitacao]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TB_SolicitacaoServico] DROP CONSTRAINT [FK_TB_SolicitacaoServico_TB_Soilcitacao];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[TB_Cidade]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_Cidade];
GO
IF OBJECT_ID(N'[dbo].[TB_Estado]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_Estado];
GO
IF OBJECT_ID(N'[dbo].[TB_LocalizacaoUsuario]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_LocalizacaoUsuario];
GO
IF OBJECT_ID(N'[dbo].[TB_PerfilUsuario]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_PerfilUsuario];
GO
IF OBJECT_ID(N'[dbo].[TB_Servico]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_Servico];
GO
IF OBJECT_ID(N'[dbo].[TB_ServicoUsuario]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_ServicoUsuario];
GO
IF OBJECT_ID(N'[dbo].[TB_Solicitacao]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_Solicitacao];
GO
IF OBJECT_ID(N'[dbo].[TB_SolicitacaoServico]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_SolicitacaoServico];
GO
IF OBJECT_ID(N'[dbo].[TB_SolicitacaoStatus]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_SolicitacaoStatus];
GO
IF OBJECT_ID(N'[dbo].[TB_Usuario]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TB_Usuario];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'TB_Cidade'
CREATE TABLE [dbo].[TB_Cidade] (
    [idCidade] int IDENTITY(1,1) NOT NULL,
    [idEstado] int  NOT NULL,
    [cidade] varchar(100)  NOT NULL
);
GO

-- Creating table 'TB_Estado'
CREATE TABLE [dbo].[TB_Estado] (
    [idEstado] int  NOT NULL,
    [estado] varchar(50)  NOT NULL,
    [sigla] varchar(2)  NOT NULL
);
GO

-- Creating table 'TB_LocalizacaoUsuario'
CREATE TABLE [dbo].[TB_LocalizacaoUsuario] (
    [idLocalizacao] int IDENTITY(1,1) NOT NULL,
    [idUsuario] int  NOT NULL,
    [latitude] float  NOT NULL,
    [longitude] float  NOT NULL,
    [dataUltimaAtualzacao] datetime  NULL,
    [distancia] float  NULL
);
GO

-- Creating table 'TB_PerfilUsuario'
CREATE TABLE [dbo].[TB_PerfilUsuario] (
    [idPerfilUsuario] int IDENTITY(1,1) NOT NULL,
    [idUsuario] int  NOT NULL,
    [nome] varchar(255)  NOT NULL,
    [cpf] varchar(11)  NOT NULL,
    [email] varchar(70)  NOT NULL,
    [endereco] varchar(70)  NOT NULL,
    [numero] varchar(10)  NOT NULL,
    [complemento] varchar(100)  NOT NULL,
    [bairro] varchar(50)  NOT NULL,
    [cep] varchar(8)  NOT NULL,
    [idEstado] int  NOT NULL,
    [idCidade] int  NOT NULL,
    [tipoPerfil] varchar(50)  NULL
);
GO

-- Creating table 'TB_Servico'
CREATE TABLE [dbo].[TB_Servico] (
    [idServico] int IDENTITY(1,1) NOT NULL,
    [descricao] varchar(100)  NULL,
    [flAtivo] bit  NULL,
    [Imagem] varchar(250)  NULL
);
GO

-- Creating table 'TB_ServicoUsuario'
CREATE TABLE [dbo].[TB_ServicoUsuario] (
    [idServicoUsuario] int  NOT NULL,
    [idServico] int  NOT NULL,
    [idUsuario] int  NOT NULL
);
GO

-- Creating table 'TB_SolicitacaoServico'
CREATE TABLE [dbo].[TB_SolicitacaoServico] (
    [idSolicitacaoServico] int IDENTITY(1,1) NOT NULL,
    [IdSolicitacao] int  NOT NULL,
    [idServico] int  NOT NULL,
    [qtde] int  NULL
);
GO

-- Creating table 'TB_SolicitacaoStatus'
CREATE TABLE [dbo].[TB_SolicitacaoStatus] (
    [idSolicitacaoStatus] int IDENTITY(1,1) NOT NULL,
    [descricao] varchar(100)  NULL,
    [flAtivo] bit  NULL
);
GO

-- Creating table 'TB_Usuario'
CREATE TABLE [dbo].[TB_Usuario] (
    [idUsuario] int IDENTITY(1,1) NOT NULL,
    [Login] varchar(70)  NOT NULL,
    [Senha] varbinary(8000)  NOT NULL,
    [flAtivo] bit  NOT NULL,
    [dtCriacao] datetime  NOT NULL,
    [dtAtivacao] datetime  NOT NULL,
    [dtInativacao] datetime  NULL
);
GO

-- Creating table 'TB_Solicitacao'
CREATE TABLE [dbo].[TB_Solicitacao] (
    [idSolicitacao] int IDENTITY(1,1) NOT NULL,
    [idStatus] int  NOT NULL,
    [dtCricao] datetime  NULL,
    [idUsuarioOrigem] int  NULL,
    [idUsuarioDestino] int  NULL,
    [dtRetirada] datetime  NULL,
    [dtRecebidoCentral] datetime  NULL,
    [dtValidacao] datetime  NULL,
    [dtEnvioDestino] datetime  NULL,
    [dtEntregue] datetime  NULL,
    [dtDevolucao] datetime  NULL,
    [idDevolucaoMotivo] int  NULL,
    [obsMotivoDevolucao] varchar(2000)  NULL,
    [recebidoPor] varchar(200)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [idCidade] in table 'TB_Cidade'
ALTER TABLE [dbo].[TB_Cidade]
ADD CONSTRAINT [PK_TB_Cidade]
    PRIMARY KEY CLUSTERED ([idCidade] ASC);
GO

-- Creating primary key on [idEstado] in table 'TB_Estado'
ALTER TABLE [dbo].[TB_Estado]
ADD CONSTRAINT [PK_TB_Estado]
    PRIMARY KEY CLUSTERED ([idEstado] ASC);
GO

-- Creating primary key on [idLocalizacao] in table 'TB_LocalizacaoUsuario'
ALTER TABLE [dbo].[TB_LocalizacaoUsuario]
ADD CONSTRAINT [PK_TB_LocalizacaoUsuario]
    PRIMARY KEY CLUSTERED ([idLocalizacao] ASC);
GO

-- Creating primary key on [idPerfilUsuario] in table 'TB_PerfilUsuario'
ALTER TABLE [dbo].[TB_PerfilUsuario]
ADD CONSTRAINT [PK_TB_PerfilUsuario]
    PRIMARY KEY CLUSTERED ([idPerfilUsuario] ASC);
GO

-- Creating primary key on [idServico] in table 'TB_Servico'
ALTER TABLE [dbo].[TB_Servico]
ADD CONSTRAINT [PK_TB_Servico]
    PRIMARY KEY CLUSTERED ([idServico] ASC);
GO

-- Creating primary key on [idServicoUsuario] in table 'TB_ServicoUsuario'
ALTER TABLE [dbo].[TB_ServicoUsuario]
ADD CONSTRAINT [PK_TB_ServicoUsuario]
    PRIMARY KEY CLUSTERED ([idServicoUsuario] ASC);
GO

-- Creating primary key on [idSolicitacaoServico] in table 'TB_SolicitacaoServico'
ALTER TABLE [dbo].[TB_SolicitacaoServico]
ADD CONSTRAINT [PK_TB_SolicitacaoServico]
    PRIMARY KEY CLUSTERED ([idSolicitacaoServico] ASC);
GO

-- Creating primary key on [idSolicitacaoStatus] in table 'TB_SolicitacaoStatus'
ALTER TABLE [dbo].[TB_SolicitacaoStatus]
ADD CONSTRAINT [PK_TB_SolicitacaoStatus]
    PRIMARY KEY CLUSTERED ([idSolicitacaoStatus] ASC);
GO

-- Creating primary key on [idUsuario] in table 'TB_Usuario'
ALTER TABLE [dbo].[TB_Usuario]
ADD CONSTRAINT [PK_TB_Usuario]
    PRIMARY KEY CLUSTERED ([idUsuario] ASC);
GO

-- Creating primary key on [idSolicitacao] in table 'TB_Solicitacao'
ALTER TABLE [dbo].[TB_Solicitacao]
ADD CONSTRAINT [PK_TB_Solicitacao]
    PRIMARY KEY CLUSTERED ([idSolicitacao] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [idEstado] in table 'TB_Cidade'
ALTER TABLE [dbo].[TB_Cidade]
ADD CONSTRAINT [FK_TB_Cidade_TB_Estado]
    FOREIGN KEY ([idEstado])
    REFERENCES [dbo].[TB_Estado]
        ([idEstado])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_Cidade_TB_Estado'
CREATE INDEX [IX_FK_TB_Cidade_TB_Estado]
ON [dbo].[TB_Cidade]
    ([idEstado]);
GO

-- Creating foreign key on [idCidade] in table 'TB_PerfilUsuario'
ALTER TABLE [dbo].[TB_PerfilUsuario]
ADD CONSTRAINT [FK_TB_PerfilUsuario_TB_Cidade]
    FOREIGN KEY ([idCidade])
    REFERENCES [dbo].[TB_Cidade]
        ([idCidade])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_PerfilUsuario_TB_Cidade'
CREATE INDEX [IX_FK_TB_PerfilUsuario_TB_Cidade]
ON [dbo].[TB_PerfilUsuario]
    ([idCidade]);
GO

-- Creating foreign key on [idEstado] in table 'TB_PerfilUsuario'
ALTER TABLE [dbo].[TB_PerfilUsuario]
ADD CONSTRAINT [FK_TB_PerfilUsuario_TB_Estado]
    FOREIGN KEY ([idEstado])
    REFERENCES [dbo].[TB_Estado]
        ([idEstado])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_PerfilUsuario_TB_Estado'
CREATE INDEX [IX_FK_TB_PerfilUsuario_TB_Estado]
ON [dbo].[TB_PerfilUsuario]
    ([idEstado]);
GO

-- Creating foreign key on [idUsuario] in table 'TB_LocalizacaoUsuario'
ALTER TABLE [dbo].[TB_LocalizacaoUsuario]
ADD CONSTRAINT [FK_TB_LocalizacaoUsuario_TB_Usuario]
    FOREIGN KEY ([idUsuario])
    REFERENCES [dbo].[TB_Usuario]
        ([idUsuario])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_LocalizacaoUsuario_TB_Usuario'
CREATE INDEX [IX_FK_TB_LocalizacaoUsuario_TB_Usuario]
ON [dbo].[TB_LocalizacaoUsuario]
    ([idUsuario]);
GO

-- Creating foreign key on [idUsuario] in table 'TB_PerfilUsuario'
ALTER TABLE [dbo].[TB_PerfilUsuario]
ADD CONSTRAINT [FK_TB_PerfilUsuario_TB_Usuario]
    FOREIGN KEY ([idUsuario])
    REFERENCES [dbo].[TB_Usuario]
        ([idUsuario])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_PerfilUsuario_TB_Usuario'
CREATE INDEX [IX_FK_TB_PerfilUsuario_TB_Usuario]
ON [dbo].[TB_PerfilUsuario]
    ([idUsuario]);
GO

-- Creating foreign key on [idServico] in table 'TB_ServicoUsuario'
ALTER TABLE [dbo].[TB_ServicoUsuario]
ADD CONSTRAINT [FK_TB_ServicoUsuario_TB_Servico]
    FOREIGN KEY ([idServico])
    REFERENCES [dbo].[TB_Servico]
        ([idServico])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_ServicoUsuario_TB_Servico'
CREATE INDEX [IX_FK_TB_ServicoUsuario_TB_Servico]
ON [dbo].[TB_ServicoUsuario]
    ([idServico]);
GO

-- Creating foreign key on [idServico] in table 'TB_SolicitacaoServico'
ALTER TABLE [dbo].[TB_SolicitacaoServico]
ADD CONSTRAINT [FK_TB_SolicitacaoServico_TB_Servico]
    FOREIGN KEY ([idServico])
    REFERENCES [dbo].[TB_Servico]
        ([idServico])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_SolicitacaoServico_TB_Servico'
CREATE INDEX [IX_FK_TB_SolicitacaoServico_TB_Servico]
ON [dbo].[TB_SolicitacaoServico]
    ([idServico]);
GO

-- Creating foreign key on [idUsuario] in table 'TB_ServicoUsuario'
ALTER TABLE [dbo].[TB_ServicoUsuario]
ADD CONSTRAINT [FK_TB_ServicoUsuario_TB_Usuario]
    FOREIGN KEY ([idUsuario])
    REFERENCES [dbo].[TB_Usuario]
        ([idUsuario])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_ServicoUsuario_TB_Usuario'
CREATE INDEX [IX_FK_TB_ServicoUsuario_TB_Usuario]
ON [dbo].[TB_ServicoUsuario]
    ([idUsuario]);
GO

-- Creating foreign key on [idSolicitacao] in table 'TB_Solicitacao'
ALTER TABLE [dbo].[TB_Solicitacao]
ADD CONSTRAINT [FK_TB_Soilcitacao_TB_Soilcitacao1]
    FOREIGN KEY ([idSolicitacao])
    REFERENCES [dbo].[TB_Solicitacao]
        ([idSolicitacao])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [idStatus] in table 'TB_Solicitacao'
ALTER TABLE [dbo].[TB_Solicitacao]
ADD CONSTRAINT [FK_TB_Soilcitacao_TB_SolicitacaoStatus1]
    FOREIGN KEY ([idStatus])
    REFERENCES [dbo].[TB_SolicitacaoStatus]
        ([idSolicitacaoStatus])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_Soilcitacao_TB_SolicitacaoStatus1'
CREATE INDEX [IX_FK_TB_Soilcitacao_TB_SolicitacaoStatus1]
ON [dbo].[TB_Solicitacao]
    ([idStatus]);
GO

-- Creating foreign key on [IdSolicitacao] in table 'TB_SolicitacaoServico'
ALTER TABLE [dbo].[TB_SolicitacaoServico]
ADD CONSTRAINT [FK_TB_SolicitacaoServico_TB_Soilcitacao1]
    FOREIGN KEY ([IdSolicitacao])
    REFERENCES [dbo].[TB_Solicitacao]
        ([idSolicitacao])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TB_SolicitacaoServico_TB_Soilcitacao1'
CREATE INDEX [IX_FK_TB_SolicitacaoServico_TB_Soilcitacao1]
ON [dbo].[TB_SolicitacaoServico]
    ([IdSolicitacao]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------