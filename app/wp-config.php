<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wordpress' );

/** Database password */
define( 'DB_PASSWORD', 'wordpress' );

/** Database hostname */
define( 'DB_HOST', 'mysql' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '81aflNC*>Bs[~#;]EBCW7G?{oa[%F=t}5$!Mf|hy<dP3j+^l_>HVs!.eV5tt1v91');
define('SECURE_AUTH_KEY',  '0)r`_~R=PREETo5MDQ6+IhFV}%$4zrr) *%J=+k:--f)TE{:)r/nRZ+PCC&kVJe+');
define('LOGGED_IN_KEY',    'bO(~PL^lNt-5|9#(C@LQ?Zqu;.d6U3(Ta`;S8{XQkfP8Z@IBZg4,MgoiFO7rVq,7');
define('NONCE_KEY',        'XMtw}bXjX,279^F/b*V_|8Y5?jaxuy~:^62gUF>;iX-!ZvCJ&{hD@*^Xpx#m:.^-');
define('AUTH_SALT',        'V?yEcvY|+YxYx97;rQ~u;+%;|^8H?--AM|XKW-,F+NbGR-S9B&fxVez#dpJgB&C9');
define('SECURE_AUTH_SALT', '$,4Z0|CbuFv_CeHc|nTTi^y4d-:|PaioFGN|{n_pL_X0-q`BPc|E+eb[J[>|$$^a');
define('LOGGED_IN_SALT',   'ZvjHq DjjFUqeCJ^P6-P5PR5H+w7p.w =CuLej9[YD|j-8BP3R#b`PR;(6:@yD;q');
define('NONCE_SALT',       'cwlYXW&_H&/ys1?0hXRu[97V>m+lkM95MicPM(B_7RxZq$b?1_M.wa8&8{G;e%ag');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';