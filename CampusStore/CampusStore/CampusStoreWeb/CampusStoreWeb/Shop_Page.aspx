<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shop_Page.aspx.cs" Inherits="CampusStoreWeb.Shop_Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="row">

            <!-- ============================================= -->
            <!-- COLUMNA IZQUIERDA: FILTROS                    -->
            <!-- ============================================= -->
            <aside class="col-md-3">
                <div class="filters-sidebar">
                    
                    <!-- SECCIÓN DE CATEGORÍAS (usando radios) -->
                    <div class="filter-section">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="categoria" id="catLibros" checked>
                            <label class="form-check-label" for="catLibros">Libros</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="categoria" id="catMochilas">
                            <label class="form-check-label" for="catMochilas">Mochilas</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="categoria" id="catCuadernos">
                            <label class="form-check-label" for="catCuadernos">Cuadernos</label>
                        </div>
                         <div class="form-check">
                            <input class="form-check-input" type="radio" name="categoria" id="catPeluches">
                            <label class="form-check-label" for="catPeluches">Peluches</label>
                        </div>
                         <div class="form-check">
                            <input class="form-check-input" type="radio" name="categoria" id="catTomatodos">
                            <label class="form-check-label" for="catTomatodos">Tomatodos</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="categoria" id="catUtiles">
                            <label class="form-check-label" for="catUtiles">Utiles</label>
                        </div>
                    </div>

                    <!-- SECCIÓN DE EDITORIALES -->
                    <div class="filter-section">
                        <h4>EDITORIALES</h4>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="editPenguin" checked>
                            <label class="form-check-label" for="editPenguin">Penguin Random House</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="editHarper" checked>
                            <label class="form-check-label" for="editHarper">HarperCollins</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="editSimon" checked>
                            <label class="form-check-label" for="editSimon">Simon & Schuster</label>
                        </div>
                         <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="editPlaneta" checked>
                            <label class="form-check-label" for="editPlaneta">Planeta</label>
                        </div>
                    </div>

                    <!-- SECCIÓN DE AUTORES -->
                    <div class="filter-section">
                        <h4>AUTORES</h4>
                        <div class="form-check">
                             <input class="form-check-input" type="checkbox" id="autGaston" checked>
                            <label class="form-check-label" for="autGaston">Gaston Acurio</label>
                        </div>
                    </div>

                    <!-- SECCIÓN DE GÉNERO -->
                    <div class="filter-section">
                        <h4>GÉNERO LIBRO</h4>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="genNovela" checked><label for="genNovela">Novela</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="genRomantico" checked><label for="genRomantico">Romántico</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="genFantasia" checked><label for="genFantasia">Fantasía</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="genCiencia" checked><label for="genCiencia">Ciencia ficción</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="genMisterio" checked><label for="genMisterio">Misterio / Suspenso</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="genAventura" checked><label for="genAventura">Aventura</label></div>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="genHistorico" checked><label for="genHistorico">Histórico</label></div>
                    </div>

                </div>
            </aside>

            <!-- ============================================= -->
            <!-- COLUMNA DERECHA: PRODUCTOS                    -->
            <!-- ============================================= -->
            <main class="col-md-9">
                <div class="results-bar d-flex justify-content-between align-items-center mb-3">
                    <span>15 Results found.</span>
                </div>

                <!-- Cuadrícula de productos -->
                <div class="row">
                    
                    <!-- Producto 1 (Ejemplo) -->
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card h-100 product-card">
                            <div class="card-img-container">
                                <span class="product-tag tag-hot">HOT</span>
                                <a href="ProductoDetalle.aspx?id=1">
                                    <img class="card-img-top" src="https://via.placeholder.com/400x600/28a745/ffffff?text=Fórmula" alt="Undertale ArtBook">
                                </a>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><a href="ProductoDetalle.aspx?id=1">Formula Emprendedor</a></h5>
                                <div class="card-rating">★★★★☆ (738)</div>
                                <p class="card-text price">$70</p>
                            </div>
                        </div>
                    </div>

                    <!-- Producto 2 (Ejemplo) -->
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card h-100 product-card">
                             <div class="card-img-container">
                                <a href="ProductoDetalle.aspx?id=2">
                                    <img class="card-img-top" src="https://via.placeholder.com/400x600/6f42c1/ffffff?text=Meditaciones" alt="Meditaciones">
                                </a>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><a href="ProductoDetalle.aspx?id=2">Meditaciones</a></h5>
                                <div class="card-rating">★★★★☆ (536)</div>
                                <p class="card-text price">$2,300</p>
                            </div>
                        </div>
                    </div>

                    <!-- Producto 3 (Ejemplo) -->
                    <div class="col-lg-4 col-md-6 mb-4">
                         <div class="card h-100 product-card">
                            <div class="card-img-container">
                                <span class="product-tag tag-bestdeals">BEST DEALS</span>
                                <a href="ProductoDetalle.aspx?id=3">
                                    <img class="card-img-top" src="https://via.placeholder.com/400x600/ffc107/000000?text=Chimoc" alt="Chimoc y la Pata Leta">
                                </a>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><a href="ProductoDetalle.aspx?id=3">Chimoc y la Pata Leta</a></h5>
                                <div class="card-rating">★★★☆☆ (423)</div>
                                <p class="card-text price">$360</p>
                            </div>
                        </div>
                    </div>

                    <!-- ... puedes copiar y pegar más bloques de producto aquí para llenar la cuadrícula ... -->
                    <!-- Producto 4 -->
                     <div class="col-lg-4 col-md-6 mb-4"><div class="card h-100 product-card"><div class="card-img-container"><a href="ProductoDetalle.aspx?id=4"><img class="card-img-top" src="https://via.placeholder.com/400x600/343a40/ffffff?text=Cien Años" alt="Cien Años de Soledad"></a></div><div class="card-body"><h5 class="card-title"><a href="ProductoDetalle.aspx?id=4">Cien años de soledad</a></h5><div class="card-rating">★★★★☆ (816)</div><p class="card-text price">$80</p></div></div></div>
                    <!-- Producto 5 -->
                     <div class="col-lg-4 col-md-6 mb-4"><div class="card h-100 product-card"><div class="card-img-container"><a href="ProductoDetalle.aspx?id=5"><img class="card-img-top" src="https://via.placeholder.com/400x600/dc3545/ffffff?text=Acurio" alt="Cocinando Historias"></a></div><div class="card-body"><h5 class="card-title"><a href="ProductoDetalle.aspx?id=5">Cocinando historias</a></h5><div class="card-rating">★★★★★ (647)</div><p class="card-text price">$1,500</p></div></div></div>
                    <!-- Producto 6 -->
                    <div class="col-lg-4 col-md-6 mb-4"><div class="card h-100 product-card"><div class="card-img-container"><span class="product-tag tag-sale">25% OFF</span><a href="ProductoDetalle.aspx?id=6"><img class="card-img-top" src="https://via.placeholder.com/400x600/e83e8c/ffffff?text=Colores" alt="Colores"></a></div><div class="card-body"><h5 class="card-title"><a href="ProductoDetalle.aspx?id=6">Colores</a></h5><div class="card-rating">★★☆☆☆ (877)</div><p class="card-text price">$1,200</p></div></div></div>
                
                </div>

                <!-- PAGINACIÓN -->
                <nav class="d-flex justify-content-center mt-4">
                    <ul class="pagination">
                        <li class="page-item"><a class="page-link" href="#">&larr;</a></li>
                        <li class="page-item active"><a class="page-link" href="#">01</a></li>
                        <li class="page-item"><a class="page-link" href="#">02</a></li>
                        <li class="page-item"><a class="page-link" href="#">03</a></li>
                        <li class="page-item"><a class="page-link" href="#">04</a></li>
                        <li class="page-item"><a class="page-link" href="#">05</a></li>
                        <li class="page-item"><a class="page-link" href="#">06</a></li>
                        <li class="page-item"><a class="page-link" href="#">&rarr;</a></li>
                    </ul>
                </nav>

            </main>
        </div>
    </div>
</asp:Content>
