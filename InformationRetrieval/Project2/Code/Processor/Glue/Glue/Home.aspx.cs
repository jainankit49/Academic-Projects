using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Glue.CalculatorServiceReference;
using Glue.SolrRef;

namespace Glue
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        String[] val;
        String suggest = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //didp.Visible = false;
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //l1.Text = "";
            SolrTestClient proxy = new SolrTestClient();
            String query = queryip.Text;
            val = proxy.NounVerb(query);
            String[] result = proxy.QueryRet(val[0],val[1]);
            
            suggest= proxy.spellcheck(val[0]);
            if (suggest != null)
            {
                if (!suggest.Equals(val[0]))
                {
                    //did u mean
                    l1.Visible = false;
                    didp.Visible = true;
                    didb.Visible = true;
                    didb.Text= suggest.ToUpper();
                    val1.Value = suggest;
                    val2.Value = val[1];
                    wrong.Value = val[0];
                    
                }
            }
            else
            {
                val1.Value = val[0];
                val2.Value = val[1];
                
                if(val[1]=="")
                {

                    for (int i = 0; i < result.Length-1; i++)
                    {
                        //complete infobox

                           result[i] = result[i].Replace("{", "").Replace("}", "").Replace("|", " ").Replace("'", "").Replace("?", "").Replace("SolrDocument", "").Replace("=", "");

                        String[] info = proxy.splitter(result[i]);
                        //l1.Text = result[i]; ;
                        for(int j=0;j<info.Length;j++)
                        {
                            //l1.Text += info[j] + "\n";
                            TableRow r = new TableRow();
                            TableCell c1 = new TableCell();
                            TableCell c2 = new TableCell();
                            //c1.Text = proxy.splitrow(info[j].Replace("[", " ").Replace("]", " "))[0].Replace("_"," ");
                            c1.Text=info[j].Replace("[", " ").Replace("]", " ").Replace("_"," ");
                            c1.Font.Bold = true;
                            //c1.Text = proxy.splitrow(info[j].Replace("[", " ").Replace("]", " "))[1];
                            //c2.Text = info[j].Split(' ')[1];
                            r.Cells.Add(c1);
                            r.Cells.Add(c2);
                            itab.Rows.AddAt(j, r);

                        }
                        itab.Visible = true;
                        
                        
                    }
                }
                else
                {
                    for (int i = 0; i < result.Length-1; i++)
                    {
                        if (result[i].Replace("{", "").Replace("]","").Replace("[","").Replace("}", "").Replace("|", " ").Replace("'", "").Replace("?", "").Replace(val[1], "").Replace("SolrDocument", "").Replace("=", "").Length == 0)
                        {
                            l1.Text = "SORRY THIS INFORMATION IS CURRENTLY NOT AVAILABLE";
                        }
                        else
                        {
                            l1.Text = result[i].Replace("{", "").Replace("}", "").Replace("|", " ").Replace("[","").Replace("]","").Replace("'", "").Replace("?", "").Replace(val[1], "").Replace("SolrDocument", "").Replace("=", "");
                        }
                    }
                    more.Text = val1.Value;
                    more.Visible = true;
                    morep.Visible = true;
                }
            }
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Hits : " + result[result.Length - 1] + "');", true);
        }

        

        protected void didb_Click(object sender, EventArgs e)
        {
            //l1.Text = "";
            //didp.Visible = true;
            didp.Visible = false;
            didb.Visible = false;
            l1.Visible = true;
            SolrTestClient proxy = new SolrTestClient();
            //l1.Text = Label1.Text;
            String[] result = proxy.QueryRet(val1.Value, val2.Value);
            queryip.Text = queryip.Text.Replace(wrong.Value, val1.Value);
            if (val2.Value.Length == 0)
            {
                for (int i = 0; i < result.Length-1; i++)
                {
                    //complete infobox

                    result[i] = result[i].Replace("{", "").Replace("}", "").Replace("|", " ").Replace("'", "").Replace("?", "").Replace("SolrDocument", "").Replace("=", "");

                    String[] info = proxy.splitter(result[i]);
                    //l1.Text = result[i]; ;
                    for (int j = 0; j < info.Length; j++)
                    {
                        //l1.Text += info[j] + "\n";
                        TableRow r = new TableRow();
                        TableCell c1 = new TableCell();
                        TableCell c2 = new TableCell();
                        //c1.Text = proxy.splitrow(info[j].Replace("[", " ").Replace("]", " "))[0].Replace("_"," ");
                        c1.Text = info[j].Replace("[", " ").Replace("]", " ").Replace("_", " ");
                        c1.Font.Bold = true;
                        //c1.Text = proxy.splitrow(info[j].Replace("[", " ").Replace("]", " "))[1];
                        //c2.Text = info[j].Split(' ')[1];
                        r.Cells.Add(c1);
                        r.Cells.Add(c2);
                        itab.Rows.AddAt(j, r);

                    }
                    itab.Visible = true;
                        
                }
               
            }
            else
            {
                for (int i = 0; i < result.Length-1; i++)
                {
                    l1.Text = result[i].Replace("{", "").Replace("}", "").Replace("|", " ").Replace("'", "").Replace("?", "").Replace(val2.Value, "").Replace("SolrDocument", "").Replace("=", "");
                }
                more.Text = val1.Value.ToUpper();
                more.Visible = true;
                morep.Visible = true;
            }
        }

        protected void more_Click(object sender, EventArgs e)
        {
            SolrTestClient proxy = new SolrTestClient();
            String[] result = proxy.QueryRet(more.Text, "");
            
                for (int i = 0; i < result.Length-1; i++)
                {
                    //complete infobox

                    result[i] = result[i].Replace("{", "").Replace("}", "").Replace("|", " ").Replace("'", "").Replace("?", "").Replace("SolrDocument", "").Replace("=", "");

                    String[] info = proxy.splitter(result[i]);
                    //l1.Text = result[i]; ;
                    for (int j = 0; j < info.Length; j++)
                    {
                        //l1.Text += info[j] + "\n";
                        TableRow r = new TableRow();
                        TableCell c1 = new TableCell();
                        TableCell c2 = new TableCell();
                        //c1.Text = proxy.splitrow(info[j].Replace("[", " ").Replace("]", " "))[0].Replace("_"," ");
                        c1.Text = info[j].Replace("[", " ").Replace("]", " ").Replace("_", " ");
                        c1.Font.Bold = true;
                        //c1.Text = proxy.splitrow(info[j].Replace("[", " ").Replace("]", " "))[1];
                        //c2.Text = info[j].Split(' ')[1];
                        r.Cells.Add(c1);
                        r.Cells.Add(c2);
                        itab.Rows.AddAt(j, r);

                    }
                    itab.Visible = true;
                        
                }
                more.Visible = false;
                morep.Visible = false;
            
        }


    }
}