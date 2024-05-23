using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace kursach1
{
    /// <summary>
    /// Логика взаимодействия для App.xaml
    /// </summary>
    public partial class App : Application
    {
        public static Frame Framer;
        public static bool Role;
        public static string Needed;
        public static string Needed2;
        public static string Needed3;
        public static string Needed4;
        public static string last;
        public static int AHAHAHAHAHAH;
        public static int waytogo;
        public static SqlConnection Connection = new SqlConnection("server=SKELETAL-COMPUT;database=Dip;trusted_connection=true");
    }
}
