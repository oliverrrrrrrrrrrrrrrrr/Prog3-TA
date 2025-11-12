<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shop_Page.aspx.cs" Inherits="CampusStoreWeb.Shop_Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">

        <!-- =================================================================== -->
        <!-- ESTE ES EL <div class="row"> PRINCIPAL QUE ENVUELVE AMBAS COLUMNAS -->
        <!-- =================================================================== -->
        <div class="row">

            <!-- ============================================= -->
            <!-- COLUMNA 1: FILTROS (col-md-3)                 -->
            <!-- ============================================= -->
            <aside class="col-md-3">
                <div class="filters-sidebar">
                    
                    <!-- SECCIÓN DE CATEGORÍAS -->
                    <div class="filter-section">
                        <h4>CATEGORÍAS</h4>
                        <asp:RadioButtonList ID="rblCategorias" runat="server" CssClass="form-check-list" RepeatLayout="Flow">
                            <asp:ListItem Value="libro" Text="Libros" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="articulo" Text="Artículos"></asp:ListItem>
                            <asp:ListItem Value="peluche" Text="Peluches"></asp:ListItem>
                            <asp:ListItem Value="tomatodo" Text="Tomatodos"></asp:ListItem>
                            <asp:ListItem Value="util" Text="Utiles"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                    <!-- SECCIÓN DE EDITORIALES -->
                    <div class="filter-section">
                        <h4>EDITORIALES</h4>
                        <asp:CheckBoxList ID="cblEditoriales" runat="server" CssClass="form-check-list">
                            <asp:ListItem Value="1">Penguin Random House</asp:ListItem> 
                            <asp:ListItem Value="2">HarperCollins</asp:ListItem>      
                            <asp:ListItem Value="3">Simon & Schuster</asp:ListItem>   
                            <asp:ListItem Value="4">Planeta</asp:ListItem>            
                        </asp:CheckBoxList>
                    </div>

                    <!-- SECCIÓN DE AUTORES -->
                    <div class="filter-section">
                        <h4>AUTORES</h4>
                        <asp:CheckBoxList ID="cblAutores" runat="server" CssClass="form-check-list">
                            <asp:ListItem Value="1">Gaston Acurio</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>

                    <!-- SECCIÓN DE GÉNERO -->
                    <div class="filter-section">
                        <h4>GÉNERO LIBRO</h4>
                        <asp:CheckBoxList ID="cblGeneros" runat="server" CssClass="form-check-list">
                            <asp:ListItem Value="NOVELA">Novela</asp:ListItem>
                            <asp:ListItem Value="ROMANTICO">Romántico</asp:ListItem>
                            <asp:ListItem Value="FANTASIA">Fantasía</asp:ListItem>
                            <asp:ListItem Value="CIENCIA_FICCION">Ciencia ficción</asp:ListItem>
                            <asp:ListItem Value="MISTERIO_SUSPENSO">Misterio / Suspenso</asp:ListItem>
                            <asp:ListItem Value="AVENTURA">Aventura</asp:ListItem>
                            <asp:ListItem Value="HISTORICO">Histórico</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                    
                    <div>
                        <asp:Button ID="btnAplicarFiltros" runat="server" Text="Aplicar Filtros" OnClick="btnAplicarFiltros_Click" CssClass="btn btn-outline-primary" />
                    </div>
                </div>
            </aside>

            <!-- ============================================= -->
            <!-- COLUMNA 2: PRODUCTOS (col-md-9)               -->
            <!-- ============================================= -->
            <main class="col-md-9">
                <!-- Fila INTERNA para la cuadrícula de productos y el mensaje -->
                <div class="row">
                    
                    <!-- El Repeater que genera las tarjetas de producto -->
                    <asp:Repeater ID="rptProductos" runat="server">
                        <ItemTemplate>
                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="card h-100 product-card">
                                    <div class="card-img-container">
                                        <a href='<%# Eval("TipoProducto", "Product_detail.aspx?type={0}&id=") + Eval("Id") %>'>
                                            <asp:Image runat="server" CssClass="card-img-top" ImageUrl='<%# Eval("UrlImagen") %>' AlternateText='<%# Eval("Nombre") %>' />
                                        </a>
                                        <div class="product-actions">
                                            <%-- Tus botones de acción aquí --%>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <a href='<%# Eval("TipoProducto", "Product_detail.aspx?type={0}&id=") + Eval("Id") %>'><%# Eval("Nombre") %></a>
                                        </h5>
                                        <p class="card-text price"><%# Eval("Precio", "${0:C}") %></p>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <!-- El Panel para el mensaje de "No hay productos" -->
                    <div class="col-12">
                         <asp:Panel ID="pnlNoResults" runat="server" Visible="false" CssClass="text-center mt-5">
                            <h4>No se encontraron productos con estas características.</h4>
                            <p>Intenta ajustar tus filtros o selecciona otra categoría.</p>
                        </asp:Panel>
                    </div>

                </div> <!-- CORRECCIÓN: Este es el cierre de la fila INTERNA de contenido -->

                <!-- PAGINACIÓN -->
                <nav class="d-flex justify-content-center mt-4">
                    <ul class="pagination">
                        <li class="page-item"><a class="page-link" href="#">&larr;</a></li>
                        <li class="page-item active"><a class="page-link" href="#">01</a></li>
                        <li class="page-item"><a class="page-link" href="#">&rarr;</a></li>
                    </ul>
                </nav>

            </main>
          
        </div> <!-- CORRECCIÓN: Este es el CIERRE CORRECTO del <div class="row"> PRINCIPAL -->

    </div>
</asp:Content>