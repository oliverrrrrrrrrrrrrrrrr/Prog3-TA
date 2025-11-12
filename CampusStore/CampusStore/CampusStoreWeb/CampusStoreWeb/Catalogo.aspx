<%@ Page Title="Catalogo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Catalogo.aspx.cs" Inherits="CampusStoreWeb.Catalogo" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Hoja de estilos específica para esta página --%>
    <style>
        .category-section h2,
        .products-area h2 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 30px;
        }

        /* Estilos para las categorías */
        .category-grid {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .category-item {
            border: 1px solid #e4e7e9;
            border-radius: 8px;
            text-align: center;
            padding: 20px;
            width: 180px;
            transition: box-shadow 0.3s, transform 0.3s;
            background-color: white;
            text-decoration: none;
            color: #191c1f;
        }

        .category-item:hover {
            box-shadow: 0 8px 24px rgba(25, 28, 31, 0.12);
            transform: translateY(-5px);
            color: #191c1f;
        }

        .category-item img {
            max-width: 120px;
            height: 120px;
            object-fit: contain;
            margin-bottom: 15px;
        }

        .category-item p {
            font-weight: 500;
            font-size: 16px;
            margin: 0;
        }

        /* Sección de productos destacados */
        .promo-banner {
            background-color: #f3de6d;
            border-radius: 5px;
            padding: 30px;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .promo-banner h3 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .promo-banner .subtitle {
            font-size: 16px;
            color: #475156;
            margin-bottom: 15px;
        }

        .offer-countdown {
            margin-bottom: 25px;
        }

        .countdown-timer {
            background-color: white;
            padding: 6px 12px;
            border-radius: 4px;
            font-weight: 600;
            margin-left: 5px;
        }

        .promo-banner .btn-promo {
            background-color: #fa8232;
            color: white;
            font-weight: bold;
            padding: 15px 30px;
            border-radius: 5px;
            text-decoration: none;
            display: block;
            margin-bottom: 20px;
        }

        .promo-banner .banner-image {
            max-width: 100%;
            margin-top: auto; /* Empuja la imagen hacia abajo */
        }

        .products-area .products-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .product-filters ul {
            padding-left: 0;
            margin-bottom: 0;
            display: flex;
            gap: 15px;
            list-style: none;
        }
        
        .product-filters a {
            text-decoration: none;
            color: #5F6C72;
            padding: 8px;
            font-weight: 500;
        }
        
        .product-filters a.active {
            color: #191C1F;
            border-bottom: 2px solid #fa8232;
            font-weight: 700;
        }

        /* Estilos para las tarjetas de producto */
        .product-card {
            border: 1px solid #e4e7e9;
            border-radius: 5px;
            background-color: white;
            transition: box-shadow 0.3s;
            position: relative;
            overflow: hidden;
            height: 100%;
        }

        .product-card:hover {
            box-shadow: 0 8px 24px rgba(25, 28, 31, 0.12);
        }

        .product-image-container {
            padding: 15px;
            text-align: center;
        }
        
        .product-card img {
            max-width: 100%;
            height: 180px;
            object-fit: contain;
        }

        .product-info {
            padding: 15px;
            border-top: 1px solid #e4e7e9;
        }

        .product-title {
            font-size: 14px;
            height: 40px; /* Altura fija para alinear títulos */
            overflow: hidden;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 16px;
            font-weight: 700;
            color: #2DA5F3;
        }

        .original-price {
            text-decoration: line-through;
            color: #929fa5;
            font-size: 14px;
            margin-right: 8px;
        }

        .product-rating .bi-star-fill {
            color: #fa8232;
        }
        
        .product-rating .bi-star-half {
            color: #fa8232;
        }

        .product-rating .rating-count {
            font-size: 12px;
            color: #77878F;
            margin-left: 5px;
        }

        .discount-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #efd33d;
            color: #191c1f;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }

    </style>

    <!-- ======================= Sección de Categorías ======================= -->
    <section class="category-section mb-5">
        <h2>Compra por categorías</h2>
        <div class="category-grid">
            <asp:HyperLink runat="server" NavigateUrl="~/Shop_Page.aspx?categoria=libro" CssClass="category-item">
                <asp:Image runat="server" ImageUrl="~/Images/libros.png" AlternateText="Libros" />
                <p>Libros</p>
            </asp:HyperLink>
            <asp:HyperLink runat="server" NavigateUrl="~/Shop_Page.aspx?categoria=articulo" CssClass="category-item">
                <asp:Image runat="server" ImageUrl="~/Images/utiles.png" AlternateText="Todos los artículos" />
                <p>Todos los artículos</p>
            </asp:HyperLink>
            <asp:HyperLink runat="server" NavigateUrl="~/Shop_Page.aspx?categoria=LAPICERO" CssClass="category-item">
                <asp:Image runat="server" ImageUrl="~/Images/lapiceros_faber.png" AlternateText="Lapiceros" />
                <p>Lapiceros</p>
            </asp:HyperLink>
            <asp:HyperLink runat="server" NavigateUrl="~/Shop_Page.aspx?categoria=CUADERNO" CssClass="category-item">
                <asp:Image runat="server" ImageUrl="~/Images/cuaderno.png" AlternateText="Cuadernos" />
                <p>Cuadernos</p>
            </asp:HyperLink>
            <asp:HyperLink runat="server" NavigateUrl="~/Shop_Page.aspx?categoria=PELUCHE" CssClass="category-item">
                <asp:Image runat="server" ImageUrl="~/Images/peluche.png" AlternateText="Peluches" />
                <p>Peluches</p>
            </asp:HyperLink>
            <asp:HyperLink runat="server" NavigateUrl="~/Shop_Page.aspx?categoria=TOMATODO" CssClass="category-item">
                <asp:Image runat="server" ImageUrl="~/Images/tomatodo.png" AlternateText="Tomatodos" />
                <p>Tomatodos</p>
            </asp:HyperLink>
        </div>
    </section>

    <!-- ======================= Sección de Productos Destacados ======================= -->
    <%-- Nota para el desarrollador: Idealmente, esta sección de productos usaría un control como asp:Repeater o asp:ListView 
         enlazado a una base de datos para generar las tarjetas de producto dinámicamente. --%>
    <section class="featured-products-section">
        <div class="row">
            <!-- Columna del Banner de Promoción -->
            <div class="col-lg-3 mb-4">
                <aside class="promo-banner">
                    <h3>32% Descuento</h3>
                    <p class="subtitle">Para todos los productos</p>
                    <div class="offer-countdown">
                        <span>La oferta acaba en:</span>
                        <span class="countdown-timer">24 de dic, 11:59PM</span>
                    </div>
                    <asp:HyperLink runat="server" NavigateUrl="~/Shop_Page.aspx" CssClass="btn-promo">COMPRAR AHORA <i class="bi bi-arrow-right"></i></asp:HyperLink>
                    <asp:Image runat="server" ImageUrl="~/Images/gadgets.png" CssClass="banner-image" AlternateText="Artículos de tecnología en oferta"/>
                </aside>
            </div>

            <!-- Columna de Productos -->
            <div class="col-lg-9">
                <div class="products-area">
                    <div class="products-header">
                        <h2 class="h3 mb-0">Productos destacados</h2>
                        <nav class="product-filters">
                            <ul>
                                <li><asp:LinkButton ID="lnkFiltroTodos" runat="server" OnClick="FiltrarProductos_Click" CommandArgument="articulo" CssClass="active">Todos</asp:LinkButton></li>
                                <li><asp:LinkButton ID="lnkFiltroLibros" runat="server" OnClick="FiltrarProductos_Click" CommandArgument="libro">Libros</asp:LinkButton></li>
                                <li><asp:LinkButton ID="lnkFiltroLapiceros" runat="server" OnClick="FiltrarProductos_Click" CommandArgument="LAPICERO">Lapiceros</asp:LinkButton></li>
                                <li><asp:LinkButton ID="lnkFiltroCuadernos" runat="server" OnClick="FiltrarProductos_Click" CommandArgument="CUADERNO">Cuadernos</asp:LinkButton></li>
                                <li><asp:LinkButton ID="lnkFiltroPeluches" runat="server" OnClick="FiltrarProductos_Click" CommandArgument="PELUCHE">Peluches</asp:LinkButton></li>
                                <li><asp:LinkButton ID="lnkFiltroTomatodos" runat="server" OnClick="FiltrarProductos_Click" CommandArgument="TOMATODO">Tomatodos</asp:LinkButton></li>
                            </ul>
                        </nav>
                    </div>

                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                        <asp:Repeater ID="rptProductosDestacados" runat="server">
                            <ItemTemplate>
                                <div class="col">
                                    <div class="product-card">
                                        <div class="product-image-container">
                                            <asp:Image runat="server" ImageUrl='<%# Eval("UrlImagen") %>' AlternateText='<%# Eval("Nombre") %>' />
                                        </div>
                                        <div class="product-info">
                                            <div class="product-rating">
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-half"></i>
                                                <span class="rating-count">(<%# GetRandomReviews() %>)</span>
                                            </div>
                                            <p class="product-title"><%# Eval("Nombre") %></p>
                                            <p class="product-price">$<%# Eval("Precio", "{0:F2}") %></p>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
