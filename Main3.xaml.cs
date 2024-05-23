using kursach1.Windows;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace kursach1.Pages
{
    /// <summary>
    /// Логика взаимодействия для Main.xaml
    /// </summary>
    public partial class Main : Page
    {
      
        public Main()
        {
            
            InitializeComponent();
            App.Connection.Open();
            SqlCommand cmd = new SqlCommand($"select Auto_brand, Model,Car.Car_Number,Probeg, avg(wear) as avgwear from \r\nCar join Car_parts on Car.Car_Number = Car_parts.Car_Number\r\nGroup by Auto_brand, Model,Car.Car_Number,Probeg", App.Connection);
            var r = cmd.ExecuteReader();
            while (r.Read())
            {
                Res.Car f = new Res.Car(r.GetValue(0).ToString(), r.GetValue(1).ToString(), r.GetValue(2).ToString(), r.GetInt32(3), r.GetInt32(4));
                Vrooms.Items.Add(f);
            }
            App.Connection.Close();


        }

        private void btn1(object sender, RoutedEventArgs e)
        {
            if (Vrooms.SelectedIndex == -1)
                return;
            Res.Car n = (Res.Car)Vrooms.SelectedItem;
            App.AHAHAHAHAHAH = n.Car_Number;
            App.last = n.Wear;
            App.Framer.Navigate(new Pages.MainEXT());
        }

        private void btn2(object sender, RoutedEventArgs e)
        {
            if (Vrooms.SelectedIndex == -1)
                return;
            Res.Car n = (Res.Car)Vrooms.SelectedItem;
            App.AHAHAHAHAHAH = n.Car_Number;
            App.Connection.Open();
            SqlCommand cmd = new SqlCommand($"select Driver_ID from Driver where Name like '{App.Needed}'", App.Connection);
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                App.Needed = Convert.ToString(rdr.GetInt32(0));
            }
            App.Connection.Close();
            Small1 d = new Small1();
            d.Show();
        }

        private void btn3(object sender, RoutedEventArgs e)
        {
            try
            {
                Vrooms.Items.Clear();
                App.Connection.Open();
                SqlCommand cmd10 = new SqlCommand($"select Auto_brand, Model,Car.Car_Number,Probeg, avg(wear) as avgwear from \r\nCar join Car_parts on Car.Car_Number = Car_parts.Car_Number\r\nGroup by Auto_brand, Model,Car.Car_Number,Probeg", App.Connection);
                var r = cmd10.ExecuteReader();
                while (r.Read())
                {
                    Res.Car f = new Res.Car(r.GetValue(0).ToString(), r.GetValue(1).ToString(), r.GetValue(2).ToString(), r.GetInt32(3), r.GetInt32(4));
                    Vrooms.Items.Add(f);
                }
                App.Connection.Close();
            }   
            catch
            {
                MessageBox.Show("Error!");
            }
        }

        private void GoBack_Click(object sender, RoutedEventArgs e)
        {
            App.Framer.GoBack();
        }
    }
}
