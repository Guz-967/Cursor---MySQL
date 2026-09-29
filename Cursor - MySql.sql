-- CURSOR

delimiter //
CREATE PROCEDURE sp_ListaProdutosCursor()
BEGIN
	-- Declaração das variáveis
	DECLARE varNomeProduto VARCHAR(50);
    DECLARE varPrecoProduto DECIMAL(10,2);
    -- Controle de saída do laço
    DECLARE varSairLaco BOOLEAN DEFAULT FALSE;
    DECLARE varCursor CURSOR FOR SELECT productName, unitPrice FROM products;
    -- Controle se ainda existe registros dentro do cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET varSairLaco = TRUE;
    OPEN varCursor;
    -- Início do laço
    Laco: LOOP
		FETCH varCursor INTO varNomeProduto, varPrecoProduto;
        -- Condição pra sair do laço
		IF varSairLaco THEN
			LEAVE Laco;
        END IF;
        -- Print das variáveis
        SELECT varNomeProduto, varPrecoProduto;
        -- Fim do laço
    END LOOP;
    CLOSE varCursor;
END;
//

CALL sp_ListaProdutosCursor();

delimiter //
CREATE PROCEDURE sp_ListarProdutosCompletos()
BEGIN
	DECLARE	varCodCliente CHAR(5);
    DECLARE	varNomeContato VARCHAR(40);
    DECLARE varCodPedido INT;
    DECLARE varDataPedido DATETIME;
    DECLARE sairLaco BOOLEAN DEFAULT FALSE;
    DECLARE varCursor CURSOR FOR SELECT customers.customerid, customers.contactname, orders.orderid, orders.orderdate
	FROM customers INNER JOIN orders ON customers.customerid = orders.customerid;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET sairLaco = TRUE;
    
    OPEN varCursor;
		lacoImprimir: LOOP
			FETCH varCursor INTO varCodCliente, varNomeContato, varCodPedido, varDataPedido; 
			IF sairLaco THEN
				LEAVE lacoImprimir;
			END IF;
            SELECT varCodCliente, varNomeContato, varCodPedido, varDataPedido; 
        END LOOP;
    CLOSE varCursor;
END;
//

drop procedure sp_ListarProdutosCompletos;
CALL sp_ListarProdutosCompletos();
SELECT customers.customerid, customers.contactname, orders.orderid, orders.orderdate
FROM customers INNER JOIN orders ON customers.customerid = orders.customerid;