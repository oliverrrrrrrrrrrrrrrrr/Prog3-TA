<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Product_detail.aspx.cs" Inherits="CampusStoreWeb.Product_detail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-detail-page .breadcrumb { background-color: transparent; padding-left: 0; margin-bottom: 1rem; }
        .product-detail-page .main-image img { border: 1px solid #e9ecef; border-radius: 4px; max-height: 550px; width: 100%; object-fit: contain; }
        .product-detail-page .product-rating { margin-bottom: 0.5rem; font-size: 0.9rem; color: #6c757d; }
        .product-detail-page .product-rating .stars { color: #ffc107; letter-spacing: 1px; }
        .product-detail-page .product-title { font-size: 2.2rem; font-weight: 600; margin-bottom: 1rem; color: #212529; }
        .product-detail-page .meta-info { font-size: 0.9rem; line-height: 1.7; margin-bottom: 1.5rem; color: #6c757d; }
        .product-detail-page .meta-info strong { color: #343a40; font-weight: 500; }
        .product-detail-page .stock-status.in-stock { color: #198754; font-weight: 700; }
        .product-detail-page .stock-status.out-stock { color: #dc3545; font-weight: 700; }
        .product-detail-page .product-price-block { margin-bottom: 1.5rem; padding-bottom: 1.5rem; border-bottom: 1px solid #e9ecef; display: flex; align-items: center; gap: 15px; }
        .product-detail-page .current-price { font-size: 2.5rem; font-weight: 700; color: #0d6efd; }
        .product-detail-page .old-price { font-size: 1.25rem; color: #6c757d; text-decoration: line-through; }
        .product-detail-page .discount-badge { background-color: #ffc107; color: #212529; font-weight: 700; padding: 4px 8px; border-radius: 4px; font-size: 0.85rem; }
        .product-detail-page .action-buttons-container { display: flex; align-items: center; gap: 10px; margin-bottom: 2rem; }
        .product-detail-page .qty-selector { display: flex; border: 1px solid #ced4da; border-radius: 4px; height: 48px; }
        .product-detail-page .qty-selector .qty-btn { background-color: #f8f9fa; border: none; width: 40px; font-size: 1.2rem; color: #6c757d; cursor:pointer; }
        .product-detail-page .qty-selector .qty-input { width: 50px; text-align: center; border: none; border-left: 1px solid #ced4da; border-right: 1px solid #ced4da; font-weight: 700; font-size: 1.1rem; }
        .product-detail-page .btn-orange-solid, .product-detail-page .btn-orange-outline { height: 48px; padding: 0 25px; font-weight: 700; font-size: 0.9rem; text-transform: uppercase; border-radius: 4px; transition: all 0.2s; }
        .product-detail-page .btn-orange-solid { background-color: #fd7e14; border: 2px solid #fd7e14; color: white; }
        .product-detail-page .btn-orange-solid:hover { background-color: #e86a00; border-color: #e86a00; }
        .product-detail-page .btn-orange-outline { background-color: transparent; border: 2px solid #fd7e14; color: #fd7e14; }
        .product-detail-page .btn-orange-outline:hover { background-color: #fd7e14; color: white; }
        .product-detail-page .custom-tabs .nav-tabs { border-bottom: 2px solid #dee2e6; }
        .product-detail-page .custom-tabs .nav-link { color: #6c757d; font-weight: 600; border: none; border-bottom: 3px solid transparent; padding: 0.8rem 0; margin-right: 2rem; }
        .product-detail-page .custom-tabs .nav-link.active, .product-detail-page .custom-tabs .nav-link:hover { color: #212529; border-bottom-color: #fd7e14; }
        .product-detail-page .tab-content { padding: 1.5rem 0; line-height: 1.7; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <div class="container my-5 product-detail-page">
        <!-- Fila del Breadcrumb -->
        <div class="row">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item"><a href="Shop_Page.aspx">Catálogo</a></li>
                        <li class="breadcrumb-item active" aria-current="page">
                            <asp:Literal ID="litProductNameBreadcrumb" runat="server">Detalle del Producto</asp:Literal>
                        </li>
                    </ol>
                </nav>
            </div>
        </div>

        <!-- Fila Principal del Producto -->
        <div class="row">
            <!-- Columna Izquierda: Imagen -->
            <div class="col-lg-6">
                <div class="main-image">
                    <asp:Image ID="imgProducto" runat="server" CssClass="img-fluid" />
                </div>
            </div>

            <!-- Columna Derecha: Información y Acciones -->
            <div class="col-lg-6">
                <div class="product-info">
                    <div class="product-rating">
                        <span class="stars">★★★★☆</span> 
                        <span class="feedback-text"><asp:Label ID="lblRating" runat="server" Text="Sin calificación"></asp:Label></span>
                    </div>

                    <h1 class="product-title"><asp:Label ID="lblProductName" runat="server" Text="Cargando..."></asp:Label></h1>

                    <div class="meta-info">
                        <asp:Panel ID="pnlSku" runat="server" Visible="false">
                            <strong>SKU:</strong> <asp:Label ID="lblSku" runat="server"></asp:Label> <br />
                        </asp:Panel>
                        <asp:Panel ID="pnlAutor" runat="server" Visible="false">
                            <strong>Autor:</strong> <asp:Label ID="lblAutor" runat="server"></asp:Label> <br />
                        </asp:Panel>
                        <strong>Disponibilidad:</strong> <asp:Label ID="lblDisponibilidad" runat="server" CssClass="stock-status"></asp:Label> <br />
                        <strong>Categoria:</strong> <asp:Label ID="lblCategoria" runat="server"></asp:Label>
                    </div>

                    <div class="product-price-block">
                        <span class="current-price"><asp:Label ID="lblPrecio" runat="server"></asp:Label></span>
                        <asp:Panel ID="pnlPrecioAnterior" runat="server" Visible="false">
                            <span class="old-price"><asp:Label ID="lblPrecioAnterior" runat="server"></asp:Label></span>
                            <span class="discount-badge"><asp:Label ID="lblDescuento" runat="server"></asp:Label></span>
                        </asp:Panel>
                    </div>

                    <div class="action-buttons-container">
                        <div class="qty-selector">
                            <button type="button" class="qty-btn" onclick="updateQty(-1)">-</button>
                            <asp:TextBox ID="txtCantidad" runat="server" Text="1" CssClass="qty-input" onchange="validateQty()"></asp:TextBox>
                            <button type="button" class="qty-btn" onclick="updateQty(1)">+</button>
                        </div>
                        <asp:Button ID="btnAddToCart" runat="server" Text="ADD TO CART" OnClick="btnAddToCart_Click" CssClass="btn-orange-solid" />
                        <asp:Button ID="btnBuyNow" runat="server" Text="BUY NOW" OnClick="btnBuyNow_Click" CssClass="btn-orange-outline" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Fila para la Sección de Pestañas -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="custom-tabs">
                    <ul class="nav nav-tabs" id="productTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description-pane" type="button" role="tab">DESCRIPCION</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="review-tab" data-bs-toggle="tab" data-bs-target="#review-pane" type="button" role="tab">RESEÑA</button>
                        </li>
                    </ul>
                    <div class="tab-content" id="productTabContent">
                        <div class="tab-pane fade show active p-3" id="description-pane" role="tabpanel">
                            <asp:Literal ID="litDescripcion" runat="server"></asp:Literal>
                        </div>
                        <div class="tab-pane fade p-3" id="review-pane" role="tabpanel">
                            <asp:Literal ID="litReviews" runat="server" Text="No hay reseñas para este producto todavía."></asp:Literal>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript para el selector de cantidad -->
    <script type="text/javascript">
        const qtyInput = document.getElementById('<%= txtCantidad.ClientID %>');

        function updateQty(amount) {
            let currentValue = parseInt(qtyInput.value, 10);
            if (isNaN(currentValue)) currentValue = 1;

            let newValue = currentValue + amount;

            const min = parseInt(qtyInput.getAttribute('min'), 10) || 1;
            const max = parseInt(qtyInput.getAttribute('max'), 10) || 999;

            if (newValue >= min && newValue <= max) {
                qtyInput.value = newValue;
            }
        }

        function validateQty() {
            let currentValue = parseInt(qtyInput.value, 10);
            const min = parseInt(qtyInput.getAttribute('min'), 10) || 1;
            const max = parseInt(qtyInput.getAttribute('max'), 10) || 999;

            if (isNaN(currentValue) || currentValue < min) {
                qtyInput.value = min;
            } else if (currentValue > max) {
                qtyInput.value = max;
            }
        }
    </script>

</asp:Content>