![](https://raw.githubusercontent.com/microsoft/sqlworkshops/master/graphics/microsoftlogo.png)

# Copilot capabilities for SQL database in Microsoft Fabric
In this exercise, you will use **Copilot** to assist with T-SQL queries, including **auto-suggestions**, **fixing error**, and **natural language query** to increase developer efficiency and analyze your data!
There're two ways how to utilize Copilot:
- Inline in the query editor
- By opening a Copilot chat

## Section 1: Using Copilot within the query editor
In the **Query Editor** you can use T-SQL comments as a way to write Copilot prompts. After finishing a prompt press **Enter** or **Space** and Copilot will process your request and suggest SQL code to complete your query. 
There're also other capabilities such as **Explain query** and **Fix query errors**. Let's dive in.

### Task 1.1: Using Copilot within the query editor


1. select the **New Query** button on the tool bar as you did in previous module.
    

4. Copy below prompt, paste it in the query editor and press **Enter**. 

   ```
   --Create a query to get the product that is selling the most.
   ```

5. Watch for the loading spinner at the bottom of the editor to track progress, and observe how Copilot’s suggestion appears in the code.
 
   > **Note:** Copilot responses may not match what is shown in the screenshot but will provide similar results.

   Optional: If you want to continue following the lab with the exact same query, feel free to copy it
   ```
   SELECT TOP 1
   [P].[Name],
   SUM([SOD].[OrderQty]) AS TotalSold
   FROM [SalesLT].[SalesOrderDetail] AS SOD
   JOIN [SalesLT].[Product] AS P ON SOD.[ProductID] = P.[ProductID]
   GROUP BY P.[Name]
   ORDER BY TotalSold DESC;
   ``` 

6. Press the **Tab** key on your keyboard to accept the suggestion or continue typing to ignore it.

7. Select the query and click on the **Run** icon (or use keyboard shortcut `Ctrl + Enter` or `Shift + Enter`)

### Task 1.2: Copilot Quick Actions within the Query Editor

1. Open a new query and paste the following query with a syntax error and click on the **Run** icon.

   ```
   SELECT c.CustomerID, c.FirstName,c.LastName,
      COUNT(so.SalesOrderID) AS TotalPurchases,
      SUM(so.SubTotal) AS TotalSpent,
      AVG(so.SubTotal) AS AverageOrderValue,
      MAX(so.OrderDate) AS LastPurchaseDate
   FROM
      SalesLT.Customer AS c JOIN SalesLT.SalesOrderHeader AS so ON c.CustomerID = so.CustomerID
   GROUP BY c.CustomerID, c.FName, c.LName ORDER BY TotalSpent DESC;

   ```

2. Observe the query errors (issue) and then select **Fix query errors**.

   !["A picture of a demonstrating an issue and finding the Fix Query Errors button in the quick actions next to the Run button in the Query Editor.."](FixQueryErrors.png)

3. Observe the updated query along with the comment that clearly states where the issue was in the query. Now click on **Run** to see the results.
   !["A picture of a demonstrating added comment at the bottom about what was fixed and query results returned successfully."](../../img/graphics/Copilot/AutoFixComment.png)

  >**Note:** Copilot responses may not match what is shown in the screenshot but will provide similar results.

4. Aside from fixing the query errors, Copilot can also explain a query to you. Select **Explain query** and Copilot will add comments to your query explaining parts of the query.
   !["A picture of a demonstrating steps to select Explain query and then showing the inline comments in the query editor."]("../../img/graphics/Copilot/ExplainQuery.png" style="width:1200px;")

## Section 2: Using Copilot Chat Pane

### Task 2.1: Chat Pane : Natural Language to SQL

1. First open the new query or clear the previous one to have a blank query editor. Next, select the **Copilot** option.

   ![](../../img/graphics/database9.png)

2. Click on the **Get started** button.

   ![](../../img/graphics/database10.png)

3. Paste the following prompt in the **Copilot** chat box and click on **Send** button.

   ```
   Write me a query that will return the most sold product.
   ```
   !["A picture of Copilot chat pane opened with written query above."]("../../img/graphics/Copilot/ChatPaneQuery.png")

4. Read the answer now and select the **Insert** button to input code into the Query Editor.

   >**Note:** Copilot responses may not match what is shown in the screenshot but will provide similar results.
   ![]("../../img/graphics/Copilot/InsertQuery.png")

5. Select the query that was inserted by **Copilot**, click on the **Run** icon and check the **Results**. 
   >**Note:** Copilot responses may not match what is shown in the screenshot but will provide similar results.

   ![](../../img/graphics/Copilot3a.png)

### Task 2.2: Chat Pane: Get results from Copilot

1. Another way to use Copilot is to ask it to get results for you. Open the new query or clear the previous one to have a blank query editor. Paste the following question in the Copilot chat box and click on **Send** button
   ```
   What is the most sold product?
   ```

2. Observe that Copilot has returned the results in the Chat pane.

   >**Note:** Copilot responses may not match what is shown in the screenshot but will provide similar results.
   !["A picture of a demonstrating Copilot response stating what is the most sold product."](../../img/graphics/Copilot/MostSoldProduct.png)


### Task 2.3: Chat Pane: Write (with approval)

1. Copilot is also able to write and execute queries on top of your database (with approval). You can choose which type of Copilot you want to use from the dropdown.

   <img alt="A picture of a choosing modes in Copilot." src="../../img/graphics/Copilot/WriteWithApproval.png" style="width:400px;">


2. Paste the following question in the **Copilot** chat box and click on **Send** button.
   ```
   Create a view in the SalesLT schema using this query and execute it.
   ```

3. Observe the Copilot's response and select **Run** to execute the given query on top of your database.

   >**Note:** Copilot responses may not match what is shown in the screenshot but will provide similar results.
   !["A picture of a approving Copilot to execute a query."](../../img/graphics/Copilot/ExecuteWithApproval.png)

4. Wait a few seconds while Copilot executes the query.

   ![Working on it / loading widget.](../../img/graphics/Copilot/WorkingOnIt.png)

9. In the **Explorer** pane on the left, expand the **SalesLT** schema. Open the **Views** folder, then select/click the view you just created. Review the displayed results to validate that the data matches your expectations.

   ![](../../img/graphics/copilot-7.png)


## What's next
Congratulations! You have learnt how to leverage **Copilot for SQL database in Microsoft Fabric** to enhance your **query-writing** experience. With these skills, you are now better equipped to write and execute SQL queries faster and troubleshoot errors effectively using Copilot. You are ready to move on to the next exercise: 
 You're now ready to move on to the next exercise where you'll explore how vector embeddings and Retrieval-Augmented Generation (RAG) can be leveraged to generate intelligent product recommendations: RAG Implementation with Azure OpenAI


