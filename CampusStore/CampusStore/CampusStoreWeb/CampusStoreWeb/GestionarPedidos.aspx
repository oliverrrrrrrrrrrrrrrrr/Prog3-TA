<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionarPedidos.aspx.cs" Inherits="CampusStoreWeb.GestionarPedidos" %>
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
        
        /* Tabla de pedidos */
        .pedidos-card {
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 24px;
        }
        
        .pedidos-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        
        .pedidos-header h2 {
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
        
        /* Barra de búsqueda */
        .search-box {
            margin-bottom: 24px;
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            padding: 10px 40px 10px 15px;
            border: 1px solid #E4E7E9;
            border-radius: 4px;
            font-size: 14px;
            color: #5F6C72;
        }
        
        .search-box input::placeholder {
            color: #929FA5;
        }
        
        .search-box i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #5F6C72;
            font-size: 16px;
        }
        
        /* Tabla personalizada */
        .table-pedidos {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table-pedidos thead th {
            background-color: #F2F4F5;
            color: #475156;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            padding: 12px 16px;
            text-align: left;
            border-bottom: 2px solid #E4E7E9;
        }
        
        .table-pedidos tbody td {
            padding: 16px;
            color: #191C1F;
            font-size: 14px;
            border-bottom: 1px solid #E4E7E9;
        }
        
        .table-pedidos tbody tr:last-child td {
            border-bottom: none;
        }
        
        .table-pedidos tbody tr:hover {
            background-color: #F9FAFB;
        }
        
        .order-id {
            color: #191C1F;
            font-weight: 500;
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
            text-transform: uppercase;
        }
        
        .status-pagado {
            background-color: #FFF3E6;
            color: var(--primary-orange);
        }
        
        .status-entregado {
            background-color: #EAF7ED;
            color: #2DB224;
        }
        
        .status-no-pagado {
            background-color: #FFE5E5;
            color: #EE5858;
        }
        
        .order-date {
            color: #5F6C72;
            font-size: 14px;
        }
        
        .order-total {
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
        .btn-agregar-container {
            display: flex;
            justify-content: flex-end;
            padding-top: 20px;
            margin-top: 20px;
            border-top: 1px solid #E4E7E9;
        }

        .btn-agregar-articulo {
            background-color: var(--primary-orange);
            color: white;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
            text-transform: uppercase;
            box-shadow: 0 2px 8px rgba(250, 130, 50, 0.3);
        }

        .btn-agregar-articulo:hover {
            background-color: #d86f28;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(250, 130, 50, 0.4);
        }

        .btn-agregar-articulo i {
            font-size: 18px;
        }

        /* Formulario de agregar/editar inline */
        .formulario-card {
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
            border: 2px solid var(--primary-orange);
        }

        .formulario-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #E4E7E9;
        }

        .formulario-header h2 {
            font-size: 24px;
            font-weight: 600;
            color: #191C1F;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .formulario-header h2 i {
            color: var(--primary-orange);
        }

        .btn-cerrar-form {
            background: none;
            border: none;
            color: #5F6C72;
            font-size: 24px;
            cursor: pointer;
            transition: color 0.3s;
            padding: 0;
            line-height: 1;
        }

        .btn-cerrar-form:hover {
            color: var(--primary-orange);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group-full {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            color: #475156;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
            text-transform: uppercase;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #E4E7E9;
            border-radius: 4px;
            font-size: 14px;
            color: #191C1F;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-orange);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #E4E7E9;
        }

        .btn-form {
            padding: 12px 30px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            text-transform: uppercase;
        }

        .btn-guardar {
            background-color: var(--primary-orange);
            color: white;
        }

        .btn-guardar:hover {
            background-color: #d86f28;
        }

        .btn-cancelar {
            background-color: #E4E7E9;
            color: #5F6C72;
        }

        .btn-cancelar:hover {
            background-color: #d1d5d9;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
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
                    <li class="breadcrumb-item active" aria-current="page">Gestionar Pedidos</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 col-md-4 mb-4">
                <div class="sidebar-menu">
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarLibros.aspx" CssClass="menu-item">
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
                    <asp:HyperLink runat="server" NavigateUrl="~/GestionarPedidos.aspx" CssClass="menu-item active">
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
                <div class="pedidos-card">
                    <!-- Header -->
                    <div class="pedidos-header">
                        <h2>PEDIDOS</h2>
                        <asp:HyperLink runat="server" NavigateUrl="~/VerTodosPedidos.aspx" CssClass="view-all-link">
                            View All <i class="bi bi-arrow-right"></i>
                        </asp:HyperLink>
                    </div>
                    
                    <!-- Barra de búsqueda -->
                    <div class="search-box">
                        <asp:TextBox ID="txtBuscarPedido" runat="server" placeholder="Ingresar ID" CssClass="form-control"></asp:TextBox>
                        <i class="bi bi-search"></i>
                    </div>
                    
                    <!-- Tabla -->
                    <div class="table-responsive">
                        <table class="table-pedidos">
                            <thead>
                                <tr>
                                    <th>ORDER ID</th>
                                    <th>STATUS</th>
                                    <th>DATE</th>
                                    <th>TOTAL</th>
                                    <th></th>
                                    <th>ACTION</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="order-id">#96459761</td>
                                    <td>
                                        <span class="status-badge status-pagado">PAGADO</span>
                                    </td>
                                    <td class="order-date">Dec 30, 2019 05:18</td>
                                    <td class="order-total">$1,500 (5 Products)</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetallePedido.aspx?id=96459761" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="order-id">#71667167</td>
                                    <td>
                                        <span class="status-badge status-entregado">ENTREGADO</span>
                                    </td>
                                    <td class="order-date">Feb 2, 2019 19:28</td>
                                    <td class="order-total">$80 (11 Products)</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetallePedido.aspx?id=71667167" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="order-id">#95214362</td>
                                    <td>
                                        <span class="status-badge status-no-pagado">NO PAGADO</span>
                                    </td>
                                    <td class="order-date">Mar 20, 2019 23:14</td>
                                    <td class="order-total">$160 (3 Products)</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetallePedido.aspx?id=95214362" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="order-id">#71667167</td>
                                    <td>
                                        <span class="status-badge status-entregado">ENTREGADO</span>
                                    </td>
                                    <td class="order-date">Feb 2, 2019 19:28</td>
                                    <td class="order-total">$80 (1 Products)</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetallePedido.aspx?id=71667167" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="order-id">#51746385</td>
                                    <td>
                                        <span class="status-badge status-entregado">ENTREGADO</span>
                                    </td>
                                    <td class="order-date">Feb 2, 2019 19:28</td>
                                    <td class="order-total">$2,300 (2 Products)</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetallePedido.aspx?id=51746385" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="order-id">#51746385</td>
                                    <td>
                                        <span class="status-badge status-entregado">ENTREGADO</span>
                                    </td>
                                    <td class="order-date">Dec 30, 2019 07:52</td>
                                    <td class="order-total">$70 (1 Products)</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetallePedido.aspx?id=51746385" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="order-id">#673971743</td>
                                    <td>
                                        <span class="status-badge status-entregado">ENTREGADO</span>
                                    </td>
                                    <td class="order-date">Dec 7, 2019 23:26</td>
                                    <td class="order-total">$220 (1 Products)</td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn-edit" ToolTip="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:HyperLink runat="server" NavigateUrl="~/DetallePedido.aspx?id=673971743" CssClass="btn-view-details">
                                            View Details <i class="bi bi-arrow-right"></i>
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="btn-agregar-container">
                        <asp:LinkButton ID="btnAgregarPedido" runat="server" CssClass="btn-agregar-articulo" OnClick="btnAgregarPedido_Click" CausesValidation="false">
                            <i class="bi bi-plus-lg"></i>
                            Agregar Pedido
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>