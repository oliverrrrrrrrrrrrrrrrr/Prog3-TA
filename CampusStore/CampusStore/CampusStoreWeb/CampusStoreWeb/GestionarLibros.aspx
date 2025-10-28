﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionarLibros.aspx.cs" Inherits="CampusStoreWeb.GestionarLibros" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Breadcrumb personalizado */
        .breadcrumb-custom {
            background-color: #f8f9fa;
            padding: 20px 0;
            margin-bottom: 30px;
        }
        
        .breadcrumb-custom .breadcrumb {
            background-color: transparent;
            margin-bottom: 0;
            padding: 0;
        }
        
        .breadcrumb-custom .breadcrumb-item {
            font-size: 14px;
            color: #5F6C72;
        }
        
        .breadcrumb-custom .breadcrumb-item.active {
            color: var(--primary-orange);
            font-weight: 500;
        }
        
        .breadcrumb-custom .breadcrumb-item a {
            color: #5F6C72;
            text-decoration: none;
        }
        
        .breadcrumb-custom .breadcrumb-item a:hover {
            color: var(--primary-orange);
        }
        
        /* Menú lateral */
        .sidebar-menu {
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .sidebar-menu .menu-item {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: #191C1F;
            text-decoration: none;
            border-bottom: 1px solid #E4E7E9;
            transition: all 0.3s;
            gap: 12px;
            font-size: 14px;
        }
        
        .sidebar-menu .menu-item:last-child {
            border-bottom: none;
        }
        
        .sidebar-menu .menu-item i {
            font-size: 20px;
            width: 24px;
            text-align: center;
        }
        
        .sidebar-menu .menu-item:hover {
            background-color: #FFF3E6;
            color: var(--primary-orange);
        }
        
        .sidebar-menu .menu-item.active {
            background-color: var(--primary-orange);
            color: white;
        }
        
        /* Tabla de libros */
        .libros-card {
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 24px;
        }
        
        .libros-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        
        .libros-header h2 {
            font-size: 20px;
            font-weight: 600;
            color: #191C1F;
            margin: 0;
        }
        
        .view-all-link {
            color: var(--primary-orange);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .view-all-link:hover {
            color: #d86f28;
        }
        
        /* Tabla personalizada */
        .table-libros {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table-libros thead th {
            background-color: #F2F4F5;
            color: #475156;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            padding: 12px 16px;
            text-align: left;
            border-bottom: 2px solid #E4E7E9;
        }
        
        .table-libros tbody td {
            padding: 16px;
            color: #191C1F;
            font-size: 14px;
            border-bottom: 1px solid #E4E7E9;
        }
        
        .table-libros tbody tr:last-child td {
            border-bottom: none;
        }
        
        .table-libros tbody tr:hover {
            background-color: #F9FAFB;
        }
        
        .libro-id {
            color: #475156;
            font-weight: 500;
        }
        
        .libro-stock {
            font-weight: 500;
        }
        
        .libro-precio {
            font-weight: 600;
            color: #191C1F;
        }
        
        .btn-edit {
            background: none;
            border: none;
            color: #5F6C72;
            cursor: pointer;
            font-size: 18px;
            padding: 0;
            margin-right: 8px;
        }
        
        .btn-edit:hover {
            color: var(--primary-orange);
        }
        
        .btn-view-details {
            color: #2DA5F3;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .btn-view-details:hover {
            color: #1e8ed9;
        }
        
        /* Botón flotante de agregar */
        .btn-add-float {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 56px;
            height: 56px;
            background-color: var(--primary-orange);
            color: white;
            border-radius: 50%;
            border: none;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(250, 130, 50, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            z-index: 1000;
        }
        
        .btn-add-float:hover {
            background-color: #d86f28;
            transform: scale(1.1);
            box-shadow: 0 6px 16px rgba(250, 130, 50, 0.5);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Breadcrumb -->
    <div class="breadcrumb-custom">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <asp:HyperLink runat="server" NavigateUrl="~/">
                            <i class="bi bi-house-door"></i> Home
                        </asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item">
                        <asp:HyperLink runat="server" NavigateUrl="~/UserAccount.aspx">User Account</asp:HyperLink>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Gestionar Libros</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 col-md-4 mb-4">
                <div class="sidebar-menu">
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarLibros.aspx" CssClass="menu-item active">
                        <i class="bi bi-layers"></i>
                        <span>Gestionar Libros</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarArticulos.aspx" CssClass="menu-item">
                        <i class="bi bi-box-seam"></i>
                        <span>Gestionar Artículos</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarEmpleados.aspx" CssClass="menu-item">
                        <i class="bi bi-person-badge"></i>
                        <span>Gestionar Empleados</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarClientes.aspx" CssClass="menu-item">
                        <i class="bi bi-cart3"></i>
                        <span>Gestionar Clientes</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarPedidos.aspx" CssClass="menu-item">
                        <i class="bi bi-file-earmark-text"></i>
                        <span>Gestionar Pedidos</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/GenerarReportes.aspx" CssClass="menu-item">
                        <i class="bi bi-gear"></i>
                        <span>Generar Reportes</span>
                    </asp:HyperLink>
                    <asp:HyperLink runat="server" NavigateUrl="~/Logout.aspx" CssClass="menu-item">
                        <i class="bi bi-box-arrow-right"></i>
                        <span>Log out</span>
                    </asp:HyperLink>
                </div>
            </div>
            
            <!-- Contenido principal -->
            <div class="col-lg-9 col-md-8">
                <div class="libros-card">
                    <!-- Header -->
                    <div class="libros-header">
                        <h2>LIBROS</h2>
                        <asp:HyperLink runat="server" NavigateUrl="~/VerTodosLibros.aspx" CssClass="view-all-link">
                            View All <i class="bi bi-arrow-right"></i>
                        </asp:HyperLink>
                    </div>
                    
                    <!-- Tabla -->
                    <div class="table-responsive">
                        <table class="table-libros">
                            <thead>
                                <tr>
                                    <th>LIBRO ID</th>
                                    <th>STOCK</th>
                                    <th>NOMBRE</th>
                                    <th>PRECIO UNITARIO</th>
                                    <th></th>
                                    <th>DETALLE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="libro-id">#96459761</td>
                                    <td class="libro-stock">5</td>
                                    <td>El libro troll del Rubius</td>
                                    <td class="libro-precio">$150.00</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleLibro.aspx?id=96459761" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="libro-id">#71667167</td>
                                    <td class="libro-stock">11</td>
                                    <td>El codigo Da Vinci</td>
                                    <td class="libro-precio">$80.00</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleLibro.aspx?id=71667167" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="libro-id">#95214362</td>
                                    <td class="libro-stock">3</td>
                                    <td>Hábitos atómicos</td>
                                    <td class="libro-precio">$159.90</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleLibro.aspx?id=95214362" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="libro-id">#71667167</td>
                                    <td class="libro-stock">1</td>
                                    <td>La casa te elige a ti</td>
                                    <td class="libro-precio">$69.90</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleLibro.aspx?id=71667167" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="libro-id">#51746385</td>
                                    <td class="libro-stock">2</td>
                                    <td>Harry Potter y la piedra filosofal</td>
                                    <td class="libro-precio">$35.50</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleLibro.aspx?id=51746385" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="libro-id">#51746385</td>
                                    <td class="libro-stock">1</td>
                                    <td>El visitante</td>
                                    <td class="libro-precio">$69.90</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleLibro.aspx?id=51746385" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="libro-id">#673971743</td>
                                    <td class="libro-stock">1</td>
                                    <td>Undertale Art Book</td>
                                    <td class="libro-precio">$42.00</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetalleLibro.aspx?id=673971743" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Botón flotante para agregar nuevo libro -->
    <asp:LinkButton ID="btnAgregarLibro" runat="server" CssClass="btn-add-float" ToolTip="Agregar nuevo libro">
        <i class="bi bi-plus-lg"></i>
    </asp:LinkButton>
    
</asp:Content>
