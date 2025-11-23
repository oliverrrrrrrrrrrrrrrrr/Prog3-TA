<%@ Page Title="Detalles del Pedido" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="CampusStoreWeb.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Estilos específicos para Order Details */
        .breadcrumb {
            background-color: #f8f9fa;
            padding: 15px 0;
            margin-bottom: 30px;
        }

        .breadcrumb-item + .breadcrumb-item::before {
            content: ">";
            padding: 0 10px;
            color: #6c757d;
        }

        .breadcrumb-item a {
            color: #6c757d;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #2DA5F3;
        }

        .sidebar-menu {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .sidebar-menu-item {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid #E4E7E9;
            text-decoration: none;
            color: #191C1F;
            transition: background-color 0.2s;
        }

        .sidebar-menu-item:last-child {
            border-bottom: none;
        }

        .sidebar-menu-item:hover {
            background-color: #f8f9fa;
        }

        .sidebar-menu-item.active {
            background-color: #FA8232;
            color: white;
        }

        .sidebar-menu-item i {
            margin-right: 12px;
            font-size: 18px;
            width: 24px;
        }

        .order-details-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .order-details-header {
            padding: 20px 24px;
            border-bottom: 1px solid #E4E7E9;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .back-button {
            background: none;
            border: none;
            font-size: 20px;
            color: #475156;
            cursor: pointer;
            padding: 0;
            display: flex;
            align-items: center;
        }

        .back-button:hover {
            color: #191C1F;
        }

        .order-details-header h4 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
        }

        .order-summary {
            background-color: #FFF9E6;
            padding: 20px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-summary-left {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .order-id {
            font-size: 20px;
            font-weight: 600;
            color: #191C1F;
        }

        .order-info {
            font-size: 14px;
            color: #475156;
        }

        .order-total {
            font-size: 28px;
            font-weight: 700;
            color: #2DA5F3;
        }

        .order-arrival {
            padding: 16px 24px;
            background-color: #fff;
            border-bottom: 1px solid #E4E7E9;
            font-size: 14px;
            color: #475156;
        }

        .order-arrival strong {
            color: #191C1F;
        }

        .products-header {
            padding: 20px 24px;
            border-bottom: 1px solid #E4E7E9;
        }

        .products-header h5 {
            margin: 0;
            font-size: 16px;
            font-weight: 600;
            color: #191C1F;
        }

        .product-count {
            color: #475156;
            font-weight: 400;
        }

        .table-custom {
            margin: 0;
        }

        .table-custom thead {
            background-color: #F2F4F5;
        }

        .table-custom thead th {
            padding: 16px 24px;
            font-size: 12px;
            font-weight: 600;
            color: #475156;
            text-transform: uppercase;
            border-bottom: 1px solid #E4E7E9;
        }

        .table-custom tbody td {
            padding: 20px 24px;
            vertical-align: middle;
            border-bottom: 1px solid #E4E7E9;
            color: #191C1F;
        }

        .product-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border: 1px solid #E4E7E9;
            border-radius: 4px;
        }

        .product-details {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .product-category {
            font-size: 12px;
            color: #2DA5F3;
            text-transform: uppercase;
            font-weight: 600;
        }

        .product-name {
            font-size: 14px;
            color: #191C1F;
            font-weight: 500;
        }

        .btn-rating {
            color: #FA8232;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-rating:hover {
            color: #e67528;
            text-decoration: underline;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Shop_Page.aspx"><i class="bi bi-house-door"></i> Inicio</a></li>
            <li class="breadcrumb-item"><a href="Settings.aspx">Cuenta de Usuario</a></li>
            <li class="breadcrumb-item"><a href="OrderHistory.aspx">Historial de Pedidos</a></li>
            <li class="breadcrumb-item active" aria-current="page">Detalles del Pedido</li>
        </ol>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar Menu -->
            <aside class="col-md-3 mb-4">
                <div class="sidebar-menu">
                    <a href="OrderHistory.aspx" class="sidebar-menu-item active">
                        <i class="bi bi-box-seam"></i>
                        Historial de Pedidos
                    </a>
                    <a href="Shopping_Car.aspx" class="sidebar-menu-item">
                        <i class="bi bi-cart3"></i>
                        Carrito de Compras
                    </a>
                    <a href="Settings.aspx" class="sidebar-menu-item">
                        <i class="bi bi-gear"></i>
                        Configuración
                    </a>
                    <a href="LogOut.aspx" class="sidebar-menu-item">
                        <i class="bi bi-box-arrow-right"></i>
                        Cerrar Sesión
                    </a>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="col-md-9">
                <div class="order-details-container">
                    <!-- Header1 -->
                    <div class="order-details-header">
                        <a href="OrderHistory.aspx" class="back-button">
                            <i class="bi bi-arrow-left"></i>
                        </a>
                        <h4>DETALLES DEL PEDIDO</h4>
                    </div>

                    <!-- Order Summary -->
                    <div class="order-summary">
                        <div class="order-summary-left">
                            <div class="order-id">
                                <asp:Label ID="lblOrderId" runat="server" Text="#96459761"></asp:Label>
                            </div>
                            <div class="order-info">
                                <asp:Label ID="lblProductCount" runat="server" Text="4 Productos"></asp:Label>
                                <span> , </span>
                                Pedido realizado el 
                                <asp:Label ID="lblOrderDate" runat="server" Text="17 Ene, 2021"></asp:Label>
                            </div>
                        </div>
                        <div class="order-summary-right">
                            <div class="order-total">
                                <asp:Label ID="lblOrderTotal" runat="server" Text="$1199.00"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!-- Products Table -->
                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>PRODUCTOS</th>
                                <th>PRECIO</th>
                                <th>CANTIDAD</th>
                                <th>SUB-TOTAL</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptProducts" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <div class="product-info">
                                                <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' class="product-image" />
                                                <div class="product-details">
                                                    <span class="product-category"><%# Eval("Category") %></span>
                                                    <span class="product-name"><%# Eval("ProductName") %></span>
                                                </div>
                                            </div>
                                        </td>
                                        <td><strong>$<%# Eval("Price") %></strong></td>
                                        <td>x<%# Eval("Quantity") %></td>
                                        <td><strong>$<%# Eval("SubTotal") %></strong></td>
                                        <td>
                                            <asp:Panel ID="pnlRating" runat="server" Visible='<%# Eval("PuedeCalificar") %>'>
                                                <asp:LinkButton ID="lnkCalificar" runat="server" 
                                                    CssClass="btn-rating" 
                                                    CommandArgument='<%# Eval("ProductId") + "|" + Eval("ProductType") %>'
                                                    OnCommand="lnkCalificar_Command"
                                                    OnClientClick="return true;">
                                                    Dejar una Calificación <i class="bi bi-plus-circle"></i>
                                                </asp:LinkButton>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>

    <!-- Modal de Rating -->
    <div class="modal fade" id="ratingModal" tabindex="-1" aria-labelledby="ratingModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body p-4">
                    <button type="button" class="btn-close float-end" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="rating-form">
                        <div class="mb-4">
                            <label for="ddlRating" class="form-label fw-semibold">Calificación</label>
                            <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-select rating-select">
                                <asp:ListItem Value="5" Selected="True">5 Estrellas</asp:ListItem>
                                <asp:ListItem Value="4">4 Estrellas</asp:ListItem>
                                <asp:ListItem Value="3">3 Estrellas</asp:ListItem>
                                <asp:ListItem Value="2">2 Estrellas</asp:ListItem>
                                <asp:ListItem Value="1">1 Estrella</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class="mb-4">
                            <label for="txtFeedback" class="form-label fw-semibold">Comentario</label>
                            <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" Rows="4" 
                                CssClass="form-control" placeholder="Escribe tu comentario sobre nuestros productos y servicios"></asp:TextBox>
                        </div>
                        
                        <asp:Button ID="btnPublishReview" runat="server" Text="PUBLICAR RESEÑA" 
                            CssClass="btn btn-publish-review w-100" OnClick="btnPublishReview_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .rating-select {
            border: 1px solid #E4E7E9;
            padding: 12px;
            font-size: 14px;
        }

        .rating-select:focus {
            border-color: #FA8232;
            box-shadow: 0 0 0 0.2rem rgba(250, 130, 50, 0.25);
        }

        .btn-publish-review {
            background-color: #FA8232;
            color: white;
            font-weight: 700;
            padding: 14px;
            border: none;
            border-radius: 4px;
            text-transform: uppercase;
            font-size: 14px;
        }

        .btn-publish-review:hover {
            background-color: #e67528;
            color: white;
        }

        .modal-content {
            border-radius: 8px;
            border: none;
        }

        .rating-form .form-label {
            color: #191C1F;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .rating-form .form-control {
            border: 1px solid #E4E7E9;
            font-size: 14px;
        }

        .rating-form .form-control:focus {
            border-color: #FA8232;
            box-shadow: 0 0 0 0.2rem rgba(250, 130, 50, 0.25);
        }

        .rating-form .form-control::placeholder {
            color: #ADB7BC;
        }
    </style>
</asp:Content>

