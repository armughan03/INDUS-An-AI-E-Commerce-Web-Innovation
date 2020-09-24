-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 30, 2019 at 12:41 PM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `indus`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_status` varchar(50) NOT NULL,
  `order_amount` int(11) NOT NULL,
  `customer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_id` int(11) NOT NULL,
  `item` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `disc_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `prd_id` int(11) NOT NULL,
  `article_no` varchar(50) NOT NULL,
  `prd_name` varchar(255) NOT NULL,
  `prd_description` text NOT NULL,
  `prd_type` text NOT NULL,
  `prd_category` text NOT NULL,
  `prd_price` int(11) NOT NULL,
  `prd_min_price` int(11) NOT NULL,
  `image_path` text NOT NULL,
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`prd_id`, `article_no`, `prd_name`, `prd_description`, `prd_type`, `prd_category`, `prd_price`, `prd_min_price`, `image_path`, `added_on`) VALUES
(1, 'pr001', 'Ban collar black jacket', 'A full black light-weight zipper jacket with ban collars and designed with simple and stylish look.', 'garments', 'men', 2399, 1500, '../../static/products/Men/pr001.jpg', '2019-04-20 12:29:27'),
(2, 'pr002', 'Black shirt with zipper', 'A black long-sleeved, long shirt with zippers and opening on the sideways', 'garments', 'men', 999, 750, '../../static/products/Men/pr002.jpg', '2019-04-20 12:29:27'),
(3, 'pr003', 'Blue-t-shirt', 'An elegant crew neck, half-sleeved blue shirt made up of soft and high quality cotton. ', 'garments', 'men', 799, 600, '../../static/products/Men/pr003.jpg', '2019-04-20 12:29:27'),
(4, 'pr004', 'Casual woolen shirt', 'A soft woolen shirt made up of high quality fabric with two pockets in front and beautiful and contrasting black buttons', 'garments', 'men', 1499, 1100, '../../static/products/Men/pr004.jpg', '2019-04-20 12:29:27'),
(5, 'pr005', 'Men check shirt', 'Wonderful high quality fabric check shirt for men with a choice of elegant styles.', 'garments', 'men', 1299, 900, '../../static/products/Men/pr005.jpg', '2019-04-20 12:29:27'),
(6, 'pr006', 'Light blue denim jeans', 'High quality denim jeans made from imported fabric and with a cool look that will match with almost any color.', 'garments', 'men', 1499, 1000, '../../static/products/Men/pr006.jpg', '2019-04-20 12:29:27'),
(7, 'pr007', 'Diesel denim jeans', 'High quality diesel colored jeans with a stylish look and elegant fabric with strechable texture.', 'garments', 'men', 1499, 1000, '../../static/products/Men/pr007.jpg', '2019-04-20 12:29:27'),
(8, 'pr008', 'Onitsuka graphic t-shirt', 'Cool black t-shirt with a wonderful logo printed in red and white and made up of high quality fabric.', 'garments', 'men', 799, 600, '../../static/products/Men/pr008.jpg', '2019-04-20 12:29:27'),
(9, 'pr009', 'Gray casual shirt', 'Simple and decent casual shirt for men who want to look simple as well as graceful. Made from high quality cotton ', 'garments', 'men', 1299, 900, '../../static/products/Men/pr009.jpg', '2019-04-20 12:29:27'),
(10, 'pr010', 'Stylish gray casual shirt', 'Full sleeved and graceful looking casual shirt with grey color plus white texture on the soft and high quality fabric that looks appeasing for stylish outfits.', 'garments', 'men', 1299, 900, '../../static/products/Men/pr010.jpg', '2019-04-20 12:29:27'),
(11, 'pr011', 'Grey-t-shirt', 'An elegant crew neck, half-sleeved grey shirt made up of soft and high quality cotton.', 'garments', 'men', 899, 600, '../../static/products/Men/pr011.jpg', '2019-04-20 12:29:27'),
(12, 'pr012', 'Lightweight mens jacket', 'Lightweight and stylish mens jacket made up of waterproof fabric style plus water resistance in one place.', 'garments', 'men', 1999, 1500, '../../static/products/Men/pr012.jpg', '2019-04-20 12:29:27'),
(13, 'pr013', 'Karsten blue shirt', 'Royal blue half sleeved karsten collared shirt made up of fine combed cotton and having a front pocket on left.', 'garments', 'men', 1199, 900, '../../static/products/Men/pr013.png', '2019-04-20 12:29:27'),
(14, 'pr014', 'Men black trousers', 'Lightweight men black trousers made with high quality fabric to provide for a comforting and simple outerlook.', 'garments', 'men', 1299, 950, '../../static/products/Men/pr014.jpg', '2019-04-20 12:29:27'),
(15, 'pr015', 'Mens spring summer jacket', 'Lightweight men navy blue jacket made for style and grace in spring and summer seasons also providing resistance to water.', 'garments', 'men', 1399, 900, '../../static/products/Men/pr015.jpg', '2019-04-20 12:29:28'),
(16, 'pr016', 'Puma trousers gray', 'Lightweight men black grey trousers made with high quality fabric to provide for a comforting and simple outerlook and manufactured by Puma', 'garments', 'men', 1299, 950, '../../static/products/Men/pr016.jpg', '2019-04-20 12:29:28'),
(17, 'pr017', 'Purple-t-shirt', 'An elegant crew neck, half-sleeved purple shirt made up of soft and high quality cotton.', 'garments', 'men', 799, 600, '../../static/products/Men/pr017.jpg', '2019-04-20 12:29:28'),
(18, 'pr018', 'Skin jeans dark gray', 'High quality dark gray skin jeans made from imported fabric and with a cool look that will match with almost any color.', 'garments', 'men', 1499, 1100, '../../static/products/Men/pr018.jpg', '2019-04-20 12:29:28'),
(19, 'pr019', 'Slate casual shirt', 'A soft casual shirt made up of high quality fabric with two pockets in front and beautiful and a warm slate color.', 'garments', 'men', 1299, 1000, '../../static/products/Men/pr019.jpg', '2019-04-20 12:29:28'),
(20, 'pr020', 'Teal-t-shirt', 'An elegant crew neck, half-sleeved teal colored shirt made up of soft and high quality cotton.', 'garments', 'men', 799, 600, '../../static/products/Men/pr020.jpg', '2019-04-20 12:29:28'),
(21, 'pr021', 'Urban blue jeans', 'High quality urban jeans made from imported fabric and with a cool look that will match with almost any color.', 'garments', 'men', 1599, 1000, '../../static/products/Men/pr021.jpg', '2019-04-20 12:29:28'),
(22, 'pr022', 'Anchor bracelet for men', 'This bracelet is made to provide men with additional bit of style in their outlook. Its made up of high quality synthetic leather and stainless steel anchor.', 'accessories', 'men', 899, 600, '../../static/products/Men/Accessories/pr022.jpg', '2019-04-20 12:29:28'),
(23, 'pr023', 'Black buddha bracelet', 'This bracelet is made to provide men with additional bit of style in their outlook. Its made up of high quality beads with a golden buddha head', 'accessories', 'men', 899, 600, '../../static/products/Men/Accessories/pr023.jpg', '2019-04-20 12:29:28'),
(24, 'pr024', 'Chakra bracelet', 'This bracelet is made to provide men with additional bit of style in their outlook. Its made up of high quality black as well as colored beads to provide for a colorful look.', 'accessories', 'men', 899, 600, '../../static/products/Men/Accessories/pr024.jpg', '2019-04-20 12:29:28'),
(25, 'pr025', 'Hot dog pin', 'High quality little pin made to stick to your shirt or jacket to provide additional style that stylish men wants.', 'accessories', 'men', 699, 450, '../../static/products/Men/Accessories/pr025.jpg', '2019-04-20 12:29:28'),
(26, 'pr026', 'Pizza enamel pin', 'High quality little pin made to stick to your shirt or jacket to provide additional style that stylish men wants.', 'accessories', 'men', 699, 450, '../../static/products/Men/Accessories/pr026.jpg', '2019-04-20 12:29:28'),
(27, 'pr027', 'Aqua Desi Kurti for women', 'Aqua colored kurti made for women who want to look cool plus desi in their outfit. Its made up of high quality fabric with stylish design on neck and sleeves.', 'garments', 'women', 1999, 1300, '../../static/products/Women/pr027.jpg', '2019-04-20 12:29:28'),
(28, 'pr028', 'Embroidered white women top', 'Wonderful white colored shirt with flower embroidery on both sleeves. Its made up of high quality and soft fabric.', 'garments', 'women', 1499, 900, '../../static/products/Women/pr028.jpg', '2019-04-20 12:29:28'),
(29, 'pr029', 'Orange Stylish Kurti for women', 'Orange colored dress made for women who want to look cool in their outfit. Its made up of high quality fabric with fresh bright orange color.', 'garments', 'women', 1999, 1500, '../../static/products/Women/pr029.jpg', '2019-04-20 12:29:28'),
(30, 'pr030', 'Lightblue women top', 'Wonderful light blue women shirt with simple texture providing a decent look.', 'garments', 'women', 1299, 900, '../../static/products/Women/pr030.jpg', '2019-04-20 12:29:28'),
(31, 'pr031', 'Pink Kurti', 'Pink colored  kurtimade for women who want to look cool plus desi in their outfit. Its made up of high quality silky fabric with a fabulous design. ', 'garments', 'women', 1999, 1500, '../../static/products/Women/pr031.jpg', '2019-04-20 12:29:28'),
(32, 'pr032', 'Red t-shirt with pocket', 'Simple crewneck red color tee shirt for women who want to look cool in summers Its made up of high quality soft cotton fabric.', 'garments', 'women', 999, 650, '../../static/products/Women/pr032.jpg', '2019-04-20 12:29:28'),
(33, 'pr033', 'Stylish red top', 'Stylish women top with stylish design on the sleeves and edges of the shirt.', 'garments', 'women', 1299, 950, '../../static/products/Women/pr033.jpg', '2019-04-20 12:29:28'),
(34, 'pr034', 'Rama green rayon stylish top', 'Cool and wonderful rama green colored women top made up of high quality rayon fabric.', 'garments', 'women', 1299, 900, '../../static/products/Women/pr034.jpg', '2019-04-20 12:29:28'),
(35, 'pr035', 'Straight fit orange kurti', 'Perfectly designed orange kurti with straight fit made for women with simple choice of style and elegance.', 'garments', 'women', 1999, 1300, '../../static/products/Women/pr035.jpg', '2019-04-20 12:29:28'),
(36, 'pr036', 'Striped fashon t-shirt', 'Crewneck black and white striped tee shirt for women who want to look cool in summers Its made up of high quality soft cotton fabric.', 'garments', 'women', 999, 650, '../../static/products/Women/pr036.jpg', '2019-04-20 12:29:28'),
(37, 'pr037', 'Trendy flowered pattern top', 'Cute looking women top with trendy flower patterns on all over the high quality fabric making it look so damn fabulous.', 'garments', 'women', 1299, 900, '../../static/products/Women/pr037.jpg', '2019-04-20 12:29:29'),
(38, 'pr038', 'Women black top', 'Perfectly designed black with minimal design on fabric and made for women with simple choice of style and elegance.', 'garments', 'women', 1299, 1000, '../../static/products/Women/pr038.jpg', '2019-04-20 12:29:29'),
(39, 'pr039', 'Womens boho top', 'Stylish women top with stylish design on the sleeves and edges of the shirt. Made with high quality fabric having beautiful blue pattern all over', 'garments', 'women', 1799, 1100, '../../static/products/Women/pr039.jpg', '2019-04-20 12:29:29'),
(40, 'pr040', 'Black over the shoulder bag', 'Black colored over the shoulder bag made up of high quality synthetic leather and steel zippers that do not dissappoint.', 'accessories', 'women', 3999, 2700, '../../static/products/Women/Accessories/pr040.jpg', '2019-04-20 12:29:29'),
(41, 'pr041', 'Brown purse', 'Women purse with chocolate brown color made up of high quality material and quality buttons and zippers.', 'accessories', 'women', 2999, 2000, '../../static/products/Women/Accessories/pr041.jpg', '2019-04-20 12:29:29'),
(42, 'pr042', 'Light brown purse', 'Women purse with chocolate brown color made up of premium quality material and quality buttons and zippers.', 'accessories', 'women', 2999, 2200, '../../static/products/Women/Accessories/pr042.jpg', '2019-04-20 12:29:29'),
(43, 'pr043', 'Lemon purse', 'Cute lemon shaped purse for women who are looking to have cuteness and cool looking accessories', 'accessories', 'women', 2599, 1800, '../../static/products/Women/Accessories/pr043.jpg', '2019-04-20 12:29:29'),
(44, 'pr044', 'Light pink purse', 'Women purse with sweet pink color made up of premium quality material and quality buttons and zippers.', 'accessories', 'women', 2999, 2000, '../../static/products/Women/Accessories/pr044.jpg', '2019-04-20 12:29:29'),
(45, 'pr045', 'Marble fashion wristwatch', 'Wonderful black wrist watch for women. Its has premium quality soft leather straps and watch made up of water resistant material making it an excellent to have accessory.', 'accessories', 'women', 1999, 1400, '../../static/products/Women/Accessories/pr045.jpg', '2019-04-20 12:29:29'),
(46, 'pr046', 'Gold and blue necklace', 'Wonderfully designed and made necklace for women who love light and minimal jewellery with their outfits.', 'accessories', 'women', 899, 550, '../../static/products/Women/Accessories/pr046.jpg', '2019-04-20 12:29:29'),
(47, 'pr047', 'Women bracelet', 'Cool looking women bracelet made up of premium quality material and perfect for adding up more style to your outfits.', 'accessories', 'women', 699, 450, '../../static/products/Women/Accessories/pr047.jpg', '2019-04-20 12:29:29'),
(48, 'pr048', 'Threader necklace', 'Simple and decent looking necklace for women made up of high quality non corroding material.', 'accessories', 'women', 999, 699, '../../static/products/Women/Accessories/pr048.jpg', '2019-04-20 12:29:29'),
(49, 'pr049', 'Kid grey sweat pants', 'Lightweight sweat pant for kids made up of high quality soft and light woolen fabric.', 'garments', 'boy', 999, 650, '../../static/products/Kids/Boys/pr049.jpg', '2019-04-20 12:29:29'),
(50, 'pr050', 'Kid black beanie', 'Stylish beanie cap for kids made up of soft and warm fabric.', 'garments', 'boy', 899, 600, '../../static/products/Kids/Boys/pr050.jpg', '2019-04-20 12:29:29'),
(51, 'pr051', 'Kid raccoon tee', 'Stylish full sleeved black crewneck t-shirt with a raccoon print over the front made up of high quality soft fabric.', 'garments', 'boy', 999, 699, '../../static/products/Kids/Boys/pr051.jpg', '2019-04-20 12:29:29'),
(52, 'pr052', 'Black leather jacket for kids', 'Stylish kid leather jacket made up of premium quality synthetic leather.', 'garments', 'boy', 999, 699, '../../static/products/Kids/Boys/pr052.jpg', '2019-04-20 12:29:29'),
(53, 'pr053', 'Kid whale shirt', 'Stylish full sleeved black crewneck t-shirt with a raccoon print over the front made up of high quality soft fabric.', 'garments', 'boy', 999, 699, '../../static/products/Kids/Boys/pr053.jpg', '2019-04-20 12:29:29'),
(54, 'pr054', 'Kid zip-up', 'Cool looking zip up jacket for kids made up of two colored fabric blue and light grey.', 'garments', 'boy', 1999, 1400, '../../static/products/Kids/Boys/pr054.jpg', '2019-04-20 12:29:29'),
(55, 'pr055', 'Plaid shirt for kids', 'Soft woolen plaid casual shirt for kids. Its made up of fine cotton fabric and wonderful black and red color.', 'garments', 'boy', 1299, 900, '../../static/products/Kids/Boys/pr055.jpg', '2019-04-20 12:29:29'),
(56, 'pr056', 'Girls striped dress bl&w', 'Beautiful white and blue striped frock for little girls. Its made up of soft and quality fabric that doesn''t dissappoint.', 'garments', 'girl', 1499, 1000, '../../static/products/Kids/Girls/pr056.jpg', '2019-04-20 12:29:29'),
(57, 'pr057', 'Girls striped dress b&w', 'Beautiful white and black striped frock for little girls. Its made up of soft and quality fabric that doesn''t dissappoint.', 'garments', 'girl', 1499, 1000, '../../static/products/Kids/Girls/pr057.jpg', '2019-04-20 12:29:30'),
(58, 'pr058', 'Brown casuals', 'Casual brown shoes for men finely made with high quality leather adding a blast of style with jeans or shalwar kameez.', 'footwear', 'men', 2999, 2399, '../../static/products/Shoes/pr058.jpg', '2019-04-20 12:29:30'),
(59, 'pr059', 'Marc jacob lace-up shoes ', 'Stylish looking high quality lace up shoes for men by Marc Jacob. Its you are the person looking for elegance in their footwear then this product is for you.', 'footwear', 'men', 5999, 4599, '../../static/products/Shoes/pr059.jpg', '2019-04-20 12:29:30'),
(60, 'pr060', 'Men casual high sneakers', 'Cool casual sneakers with high tops for men wanting to add a touch of coolness to their styles', 'footwear', 'men', 3999, 2799, '../../static/products/Shoes/pr060.jpg', '2019-04-20 12:29:30'),
(61, 'pr061', 'Navy blue skate shoes', 'Cool casual skate shoes with amazing contrasting color for men wanting to add a touch of coolness to their styles', 'footwear', 'men', 2599, 1999, '../../static/products/Shoes/pr061.jpg', '2019-04-20 12:29:30'),
(62, 'pr062', 'Red LED shoes', 'Stylish Red colored sneakers with blue LED over the side of soles to make kids look stylish.', 'footwear', 'kids', 2999, 2499, '../../static/products/Shoes/pr062.jpg', '2019-04-20 12:29:30'),
(63, 'pr063', 'All black sneakers', 'Completely black comfortable sneakers for men made up of premium quality material and strong stitching.', 'footwear', 'men', 2999, 2499, '../../static/products/Shoes/pr063.jpg', '2019-04-20 12:29:30'),
(64, 'pr064', 'Shops23 sneakers', 'Stylish black and yellow sneakers for men who are looking to add touch of coolness to their footwear style.', 'footwear', 'men', 3499, 2999, '../../static/products/Shoes/pr064.jpg', '2019-04-20 12:29:30'),
(65, 'pr065', 'White lowtop LED shoes', 'Stylish full white colored sneakers with blue LEDs over the side of soles to make kids look stylish.', 'footwear', 'kids', 2999, 2499, '../../static/products/Shoes/pr065.jpg', '2019-04-20 12:29:30'),
(66, 'pr066', 'Kids Car t-shirt', 'Stylish full sleeved black crewneck t-shirt with a car print over the front made up of high quality soft fabric.', 'garments', 'boy', 999, 699, '../../static/products/Kids/Boys/pr066.jpg', '2019-04-20 12:29:30'),
(67, 'pr067', 'Kids Wear Kurta Shalwar', 'Fabric: Cotton\nStyle: Shalwar Kameez\nMustard Color Self Printed & Embroidered Cotton Kids/Boys Salwar Kameez.\nPrinted Sleeves.\nSelf Printed Back\nPlain White Trouser', 'Shalwar Kameez', 'boy', 1800, 1200, '../../static/products/Kids/Boys/pr067.jpg', '2019-04-20 12:29:30'),
(68, 'pr068', 'Kids Wear Kurta Shalwar', 'Fabric: Cotton\nStyle: Salwar Kameez\nBlue Color pati work over Cotton Kids/Boys Salwar Kameez.\nPlain Sleeves.\nPlain Back\nPlain White Trouser', 'Shalwar Kameez', 'boy', 1800, 1200, '../../static/products/Kids/Boys/pr068.jpg', '2019-04-20 12:29:30'),
(69, 'pr069', 'Kids Wear Kurta Shalwar', 'Blue Color Self Printed Cotton Kids/Boys Salwar Kameez.\nPrinted Sleeves.\nSelf Printed Back\nPlain White Trouser', 'Shalwar Kameez', 'boy', 1800, 1200, '../../static/products/Kids/Boys/pr069.jpg', '2019-04-20 12:29:30'),
(70, 'pr070', 'Kids Wear Kurta Shalwar', 'White Color Self Printed & Embroidered Cotton Kids/Boys Salwar Kameez.\nPrinted Sleeves.\nSelf Printed Back\nPlain White Trouser', 'Shalwar Kameez', 'boy', 1800, 1200, '../../static/products/Kids/Boys/pr070.jpg', '2019-04-20 12:29:30'),
(71, 'pr071', 'Kids Wear Kurta Shalwar', 'Fabric: Cotton\nStyle: Salwar Kameez\nWhite Color Cotton Kids/Boys Salwar Kameez.\nPlain Sleeves.\nPlain Back\nPlain White Trouser', 'Shalwar Kameez', 'boy', 1800, 1200, '../../static/products/Kids/Boys/pr071.jpg', '2019-04-20 12:29:30'),
(72, 'pr072', 'Kids Wear Kurta Shalwar', 'Mustard Color Self Printed & Embroidered Cotton Kids/Boys Salwar Kameez. It has Printed Sleeves and\nSelf Printed Back it comes with a Plain White Trouser.', 'Shalwar Kameez', 'boy', 1800, 1200, '../../static/products/Kids/Boys/pr072.jpg', '2019-04-20 12:29:30'),
(73, 'pr073', 'Kids Wear Kurta Shalwar', 'Fabric: Cotton\nStyle: Shalwar Kameez\nBlack Color Self Printed Cotton Kids/Boys Salwar Kameez.\nPrinted Sleeves.\nSelf Printed Back\nPlain White Trouser', 'Shalwar Kameez', 'boy', 1800, 1200, '../../static/products/Kids/Boys/pr073.jpg', '2019-04-20 12:29:30'),
(74, 'pr074', 'Kids Wear Kurta Shalwar', 'Fabric: Cotton\nStyle: Salwar Kameez\nPurple Color Self Printed Cotton Kids/Boys Salwar Kameez.\nPrinted Sleeves.\nSelf Printed Back\nPlain White Trouser', 'Shalwar Kameez', 'boy', 1800, 1200, '../../static/products/Kids/Boys/pr074.jpg', '2019-04-20 12:29:30'),
(75, 'pr075', 'Shoes by Armani Jeans', 'Casual shoes by Armani Jeans made with 100% quality material and strong stitching.', 'footwear', 'men', 2799, 2399, '../../static/products/Shoes/pr075.jpg', '2019-04-20 12:29:30'),
(76, '', '', '', '', '', 0, 0, '', '2019-04-20 12:29:30'),
(77, 'pr076', 'Blue denim jeans', 'High quality denim jeans made from imported fabric and with a cool look that will match with almost any color.', 'garments', 'men', 1799, 1200, '../../static/products/Men/pr076.jpg', '2019-04-20 12:29:30'),
(78, 'pr077', 'Sweat shirt & Tee Combo by Z Zegna', 'High quality cotton shirts combo. One Long Sleeved Sweat shirt and one T-shirt with a printed logo. Deal of 2 in lowest price. ', 'garments', 'men', 1799, 1399, '../../static/products/Men/pr077.jpg', '2019-04-20 12:29:31'),
(79, 'pr078', 'Sweat suit by Armani', 'A sweat shirt with a trouser made up of soft warm cotton for comfort lifestyle.', 'garments', 'men', 2399, 1799, '../../static/products/Men/pr078.jpg', '2019-04-20 12:29:31'),
(80, 'pr079', 'Coat and Jeans Combo', 'A warm casual coat by Z Zegna paired up with a white jeans made up of high quality fabric and high quality stitching.', 'garments', 'men', 3899, 3399, '../../static/products/Men/pr079.jpg', '2019-04-20 12:29:31'),
(81, 'pr080', 'SweatShirt Combo by Armani', 'A pair of two sweat shirts made up of high quality soft cotton with fleeced interior for perfect comfort.', 'garments', 'men', 2600, 2000, '../../static/products/Men/pr080.jpg', '2019-04-20 12:29:31'),
(82, 'pr081', 'Jumper Jacket by Z Zegna', 'Light weight quilted jumper/gillet made up of water proof material and also equipped with a hood.', 'garments', 'men', 1500, 1100, '../../static/products/Men/pr081.jpg', '2019-04-20 12:29:31'),
(83, 'pr082', 'Casual shirt combo', 'A pair of stylish casual shirts having different colors and cool patterns.', 'garments', 'men', 1999, 1599, '../../static/products/Men/pr082.jpg', '2019-04-20 12:29:31'),
(84, 'pr083', 'Sweat and Dress shirt combo', 'Combo of sweat shirt styled with camoflage pattern and a light blue dress shirt with french collars.', 'garments', 'men', 1999, 1699, '../../static/products/Men/pr083.jpg', '2019-04-20 12:29:31'),
(85, 'pr084', 'Kurta-1', 'Pakistani Stitch Pink Color Summer Lawn Kurta. Neck Embroidered With Tussles over Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr084.jpg', '2019-04-20 12:29:31'),
(86, 'pr085', 'Kurta-2', 'Pakistani Stitch Maroon Color Summer Lawn Kurta. Front Full Embroidered With Tussles over Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr085.jpg', '2019-04-20 12:29:31'),
(87, 'pr086', 'Kurta-3', 'Pakistani Stitch White Color Summer Lawn Kurta. Neck Embroidered With Stones at Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr086.jpg', '2019-04-20 12:29:31'),
(88, 'pr087', 'Kurta-4', 'Pakistani Stitch Green Color Summer Lawn Kurta. Neck Embroidered With Stone over Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr087.jpg', '2019-04-20 12:29:31'),
(89, 'pr088', 'Kurta-5', 'Pakistani Stitch Maroon Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr088.jpg', '2019-04-20 12:29:31'),
(90, 'pr089', 'Kurta-6', 'Pakistani Stitch Red Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr089.jpg', '2019-04-20 12:29:31'),
(91, 'pr090', 'Kurta-7', 'Pakistani Stitch Orange Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr090.jpg', '2019-04-20 12:29:31'),
(92, 'pr091', 'Kurta-8', 'Pakistani Stitch Black Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr091.jpg', '2019-04-20 12:29:31'),
(93, 'pr092', 'Kurta-9', 'Pakistani Stitch Green Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr092.jpg', '2019-04-20 12:29:31'),
(94, 'pr093', 'Kurta-10', 'Pakistani Stitch Yellow/White Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr093.jpg', '2019-04-20 12:29:31'),
(95, 'pr094', 'Kurta-11', 'Pakistani Stitch Pink Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr094.jpg', '2019-04-20 12:29:31'),
(96, 'pr095', 'Kurta-12', 'Pakistani Stitch Light Pink Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr095.jpg', '2019-04-20 12:29:31'),
(97, 'pr096', 'Kurta-13', 'Pakistani Stitch Yellow Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr096.jpg', '2019-04-20 12:29:31'),
(98, 'pr097', 'Kurta-14', 'Pakistani Stitch Grey-Blue Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr097.jpg', '2019-04-20 12:29:31'),
(99, 'pr098', 'Kurta-15', 'Pakistani Stitch Multi Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr098.jpg', '2019-04-20 12:29:31'),
(100, 'pr099', 'Kurta-16', 'Pakistani Stitch Yellow Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr099.jpg', '2019-04-20 12:29:31'),
(101, 'pr100', 'Kurta-17', 'Pakistani Stitch Multi Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr100.jpg', '2019-04-20 12:29:32'),
(102, 'pr101', 'Kurta-18', 'Pakistani Stitch light green Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr101.jpg', '2019-04-20 12:29:32'),
(103, 'pr102', 'Kurta-19', 'Pakistani Stitch Skin Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr102.jpg', '2019-04-20 12:29:32'),
(104, 'pr103', 'Kurta-20', 'Pakistani Stitch Pink Color Summer Lawn Kurta. Neck Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr103.jpg', '2019-04-20 12:29:32'),
(105, 'pr104', 'Kurta-21', 'Pakistani Stitch Dark Pink Color Summer Lawn Kurta. Full Embroidered & Printed Daman', 'Kurta', 'women', 1199, 800, '../../static/products/Women/pr104.jpg', '2019-04-20 12:29:32'),
(106, 'pr105', 'Stitched Embroidered Lawn Trouser', 'Amazing Plain Black Color Stitched Embroidered Lawn Trouser\nBlack Color Velvet Lace Work with Velvet Buttons Over Lawn Trouser Embroidered\nPacking: Plastic bag ', 'Trouser', 'women', 1299, 900, '../../static/products/Women/pr105.jpeg', '2019-04-20 12:29:32'),
(107, 'pr106', 'Stitched Embroidered Lawn Trouser', 'Amazing Plain Skin Color Stitched Embroidered Lawn Trouser\nSkin Color Chiffon Lace Work with Velvet Buttons Over Lawn Trouser Embroidered\nPacking: Plastic bag ', 'Trouser', 'women', 1299, 900, '../../static/products/Women/pr106.jpeg', '2019-04-20 12:29:32'),
(108, 'pr107', 'Stitched Embroidered Lawn Trouser', 'Amazing Plain White Color Stitched Embroidered Lawn Trouser\nWhite Color Embroidered Lace Work Over Lawn Trouser Embroidered\nPacking: Plastic bag ', 'Trouser', 'women', 1299, 900, '../../static/products/Women/pr107.jpeg', '2019-04-20 12:29:32'),
(109, 'pr108', 'Stitched Embroidered Lawn Trouser', 'Amazing Black Color Stitched Embroidered Lawn Trouser\nSliver Color Embroidery Work Over Lawn Trouser Embroidered\nPacking: Plastic bag ', 'Trouser', 'women', 999, 700, '../../static/products/Women/pr108.jpg', '2019-04-20 12:29:32'),
(110, 'pr109', 'Stitched Embroidered Lawn Trouser', 'Amazing Black Color Stitched Embroidered Lawn Trouser\nBlack Color Embroidery Work Over Lawn Trouser Embroidered\nPacking: Plastic bag ', 'Trouser', 'women', 999, 700, '../../static/products/Women/pr109.jpg', '2019-04-20 12:29:32'),
(111, 'pr110', 'Stitched Embroidered Lawn Trouser', 'Amazing White Color Stitched Embroidered Lawn Trouser\nRed Color Flower Embroidery Work Over Lawn Trouser Embroidered\nPacking: Plastic bag', 'Trouser', 'women', 999, 700, '../../static/products/Women/pr110.jpg', '2019-04-20 12:29:32'),
(112, 'pr111', 'Stitched Embroidered Lawn Trouser', 'Amazing Skin Color Stitched Embroidered Lawn Trouser\nSkin Color Embroidery Work Over Lawn Trouser Embroidered\nPacking: Plastic bag', 'Trouser', 'women', 999, 700, '../../static/products/Women/pr111.jpg', '2019-04-20 12:29:32'),
(113, 'pr112', 'Stitched Embroidered Lawn Trouser', 'Amazing Skin Color Stitched Embroidered Lawn Trouser\nSilver Color Embroidery Work Over Lawn Trouser Embroidered\nPacking: Plastic bag', 'Trouser', 'women', 999, 700, '../../static/products/Women/pr112.jpg', '2019-04-20 12:29:32'),
(114, 'pr113', 'Stitched Embroidered Lawn Trouser', 'Amazing White Color Stitched Embroidered Lawn Trouser\nWhite Color Embroidery Work Over Lawn Trouser Embroidered\nPacking: Plastic bag', 'Trouser', 'women', 999, 700, '../../static/products/Women/pr113.jpg', '2019-04-20 12:29:32'),
(115, 'pr114', 'Stitched Embroidered Lawn Trouser', 'Amazing White Color Stitched Embroidered Lawn Trouser\nSkin Color Embroidery Work Over Lawn Trouser Embroidered\nPacking: Plastic bag', 'Trouser', 'women', 999, 700, '../../static/products/Women/pr114.jpg', '2019-04-20 12:29:32'),
(116, 'pr115', 'High tops by Armani Jeans', 'Casual high topped shoes by Armani Jeans made with 100% quality material and strong stitching.', 'footwear', 'men', 3199, 2599, '../../static/products/Shoes/pr115.jpg', '2019-04-20 12:29:32');

-- --------------------------------------------------------

--
-- Table structure for table `product_sizes`
--

CREATE TABLE `product_sizes` (
  `id` int(11) NOT NULL,
  `article_no` varchar(50) NOT NULL,
  `size_s` int(11) NOT NULL,
  `size_m` int(11) NOT NULL,
  `size_l` int(11) NOT NULL,
  `size_xl` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_sizes`
--

INSERT INTO `product_sizes` (`id`, `article_no`, `size_s`, `size_m`, `size_l`, `size_xl`) VALUES
(1, 'pr001', 20, 20, 20, 20),
(2, 'pr002', 20, 20, 20, 20),
(3, 'pr003', 20, 20, 20, 20),
(4, 'pr004', 20, 20, 20, 20),
(5, 'pr005', 20, 20, 20, 20),
(6, 'pr006', 20, 20, 20, 20),
(7, 'pr007', 20, 20, 20, 20),
(8, 'pr008', 20, 20, 20, 20),
(9, 'pr009', 20, 20, 20, 20),
(10, 'pr010', 20, 20, 20, 20),
(11, 'pr011', 20, 20, 20, 20),
(12, 'pr012', 20, 20, 20, 20),
(13, 'pr013', 20, 20, 20, 20),
(14, 'pr014', 20, 20, 20, 20),
(15, 'pr015', 20, 20, 20, 20),
(16, 'pr016', 20, 20, 20, 20),
(17, 'pr017', 20, 20, 20, 20),
(18, 'pr018', 20, 20, 20, 20),
(19, 'pr019', 20, 20, 20, 20),
(20, 'pr020', 20, 20, 20, 20),
(21, 'pr021', 20, 20, 20, 20),
(22, 'pr022', 20, 20, 20, 20),
(23, 'pr023', 20, 20, 20, 20),
(24, 'pr024', 20, 20, 20, 20),
(25, 'pr025', 20, 20, 20, 20),
(26, 'pr026', 20, 20, 20, 20),
(27, 'pr027', 20, 20, 20, 20),
(28, 'pr028', 20, 20, 20, 20),
(29, 'pr029', 20, 20, 20, 20),
(30, 'pr030', 20, 20, 20, 20),
(31, 'pr031', 20, 20, 20, 20),
(32, 'pr032', 20, 20, 20, 20),
(33, 'pr033', 20, 20, 20, 20),
(34, 'pr034', 20, 20, 20, 20),
(35, 'pr035', 20, 20, 20, 20),
(36, 'pr036', 20, 20, 20, 20),
(37, 'pr037', 20, 20, 20, 20),
(38, 'pr038', 20, 20, 20, 20),
(39, 'pr039', 20, 20, 20, 20),
(40, 'pr040', 20, 20, 20, 20),
(41, 'pr041', 20, 20, 20, 20),
(42, 'pr042', 20, 20, 20, 20),
(43, 'pr043', 20, 20, 20, 20),
(44, 'pr044', 20, 20, 20, 20),
(45, 'pr045', 20, 20, 20, 20),
(46, 'pr046', 20, 20, 20, 20),
(47, 'pr047', 20, 20, 20, 20),
(48, 'pr048', 20, 20, 20, 20),
(49, 'pr049', 20, 20, 20, 20),
(50, 'pr050', 20, 20, 20, 20),
(51, 'pr051', 20, 20, 20, 20),
(52, 'pr052', 20, 20, 20, 20),
(53, 'pr053', 20, 20, 20, 20),
(54, 'pr054', 20, 20, 20, 20),
(55, 'pr055', 20, 20, 20, 20),
(56, 'pr056', 20, 20, 20, 20),
(57, 'pr057', 20, 20, 20, 20),
(58, 'pr058', 20, 20, 20, 20),
(59, 'pr059', 20, 20, 20, 20),
(60, 'pr060', 20, 20, 20, 20),
(61, 'pr061', 20, 20, 20, 20),
(62, 'pr062', 20, 20, 20, 20),
(63, 'pr063', 20, 20, 20, 20),
(64, 'pr064', 20, 20, 20, 20),
(65, 'pr065', 20, 20, 20, 20),
(66, 'pr066', 20, 20, 20, 20),
(67, 'pr067', 20, 20, 20, 20),
(68, 'pr068', 20, 20, 20, 20),
(69, 'pr069', 20, 20, 20, 20),
(70, 'pr070', 20, 20, 20, 20),
(71, 'pr071', 20, 20, 20, 20),
(72, 'pr072', 20, 20, 20, 20),
(73, 'pr073', 20, 20, 20, 20),
(74, 'pr074', 20, 20, 20, 20),
(75, 'pr075', 20, 20, 20, 20),
(76, '', 0, 0, 0, 0),
(77, 'pr076', 20, 20, 20, 20),
(78, 'pr077', 20, 20, 20, 20),
(79, 'pr078', 20, 20, 20, 20),
(80, 'pr079', 20, 20, 20, 20),
(81, 'pr080', 20, 20, 20, 20),
(82, 'pr081', 20, 20, 20, 20),
(83, 'pr082', 20, 20, 20, 20),
(84, 'pr083', 20, 20, 20, 20),
(85, 'pr084', 10, 10, 10, 10),
(86, 'pr085', 10, 10, 10, 10),
(87, 'pr086', 10, 10, 10, 10),
(88, 'pr087', 10, 10, 10, 10),
(89, 'pr088', 10, 10, 10, 10),
(90, 'pr089', 10, 10, 10, 10),
(91, 'pr090', 10, 10, 10, 10),
(92, 'pr091', 10, 10, 10, 10),
(93, 'pr092', 10, 10, 10, 10),
(94, 'pr093', 10, 10, 10, 10),
(95, 'pr094', 10, 10, 10, 10),
(96, 'pr095', 10, 10, 10, 10),
(97, 'pr096', 10, 10, 10, 10),
(98, 'pr097', 10, 10, 10, 10),
(99, 'pr098', 10, 10, 10, 10),
(100, 'pr099', 10, 10, 10, 10),
(101, 'pr100', 10, 10, 10, 10),
(102, 'pr101', 10, 10, 10, 10),
(103, 'pr102', 10, 10, 10, 10),
(104, 'pr103', 10, 10, 10, 10),
(105, 'pr104', 10, 10, 10, 10),
(106, 'pr105', 10, 10, 10, 10),
(107, 'pr106', 10, 10, 10, 10),
(108, 'pr107', 10, 10, 10, 10),
(109, 'pr108', 10, 10, 10, 10),
(110, 'pr109', 10, 10, 10, 10),
(111, 'pr110', 10, 10, 10, 10),
(112, 'pr111', 10, 10, 10, 10),
(113, 'pr112', 10, 10, 10, 10),
(114, 'pr113', 10, 10, 10, 10),
(115, 'pr114', 10, 10, 10, 10),
(116, 'pr115', 20, 20, 20, 20);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` text NOT NULL,
  `image_path` text NOT NULL,
  `register_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `user_type`, `image_path`, `register_date`) VALUES
(1, 'M.Ali', 'ali@indussh.co.pk', '$5$rounds=535000$G.chAaKIpI5B0f2t$RCZNn9jv3TltZ/LKPXhB4etncGkUnXQ2ExSrOwkmk8.', 'admin', '../../static/uploads/default.jpg', '2019-03-10 11:24:09'),
(23, 'Armughan', 'armughan@indush.co.pkh', '$5$rounds=535000$nkMCIdFkyK4zu4EZ$9WNa4Wt5y9LXGFcusNss05bR.RzrI5yKuXwG3NQx1O7', 'admin', '../../static/uploads/default.jpg', '2019-03-15 15:40:52'),
(24, 'Daniyal', 'daniyal@indushh.co.pk', '$5$rounds=535000$SHs5OqfNbARc3r0F$CedPPwT6TY/.uz84qpwRrWtWToALEB0qRWlTHEyYwn/', 'admin', '../../static/uploads/dave_avatar.jpg', '2019-03-15 15:43:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD KEY `FK_Order_items` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`prd_id`),
  ADD UNIQUE KEY `article_no` (`article_no`);

--
-- Indexes for table `product_sizes`
--
ALTER TABLE `product_sizes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_no` (`article_no`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `prd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;
--
-- AUTO_INCREMENT for table `product_sizes`
--
ALTER TABLE `product_sizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `FK_Order_items` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_sizes`
--
ALTER TABLE `product_sizes`
  ADD CONSTRAINT `product_sizes_ibfk_1` FOREIGN KEY (`article_no`) REFERENCES `products` (`article_no`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
