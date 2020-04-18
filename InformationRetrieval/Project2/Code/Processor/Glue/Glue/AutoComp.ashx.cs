using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Glue.SolrRef;

namespace Glue
{
    /// <summary>
    /// Summary description for AutoComp
    /// </summary>
    public class AutoComp : IHttpHandler
    {

         public void ProcessRequest(HttpContext context)
       {
           if (!String.IsNullOrEmpty(context.Request.QueryString["q"]))
           {
               foreach (string s in GetAutoCompleteValues(context.Request.QueryString["q"]))
               {
                   context.Response.Write(s + Environment.NewLine);
               }
           }
    
       }
       public static string[] GetAutoCompleteValues(string prefixText)
       {
           SolrTestClient proxy = new SolrTestClient();
           String[] res = proxy.AutoSug(prefixText);
           return res;
       }
    
       public bool IsReusable
       {
           get
           {
               return true;
           }
       }
   }
    
}