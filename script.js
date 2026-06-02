let produtos = [];

function adicionarProduto(){

    const nome = document.getElementById("nome").value;
    const preco = document.getElementById("preco").value;
    const quantidade = document.getElementById("quantidade").value;

    if(nome === "" || preco === "" || quantidade === ""){
        alert("Preencha todos os campos!");
        return;
    }
// adiciona um novo produto a lista
    produtos.push({
        nome: nome,
        preco: preco,
        quantidade: quantidade
    });
// reconstrói a tabela sempre que um produto novo é cadastrado
    atualizarTabela();

    document.getElementById("nome").value = "";
    document.getElementById("preco").value = "";
    document.getElementById("quantidade").value = "";
}

function atualizarTabela(){
    
    const tabela = document.getElementById("tabelaProdutos");

    tabela.innerHTML = "";

    produtos.forEach(produto => {

        tabela.innerHTML += `
            <tr>
                <td>${produto.nome}</td>
                <td>R$ ${produto.preco}</td>
                <td>${produto.quantidade}</td>
            </tr>
        `;
    });
}