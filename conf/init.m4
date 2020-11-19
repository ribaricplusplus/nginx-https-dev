ifdef(M4_INIT, [[]], [[dnl
define([[M4_INIT]], [[true]])dnl
changequote(`[[', `]]')dnl
dnl Nginx gateway timeout
define([[M_TIMEOUT]], [[300s]])dnl
dnl
dnl
dnl Development configuration
define([[DEV_CONFIG]], [[dnl
define([[M_TIMEOUT]], [[1d]])dnl
]])dnl
dnl
dnl
dnl Override default configuration in development
ifelse(M_DEV, [[true]], [[DEV_CONFIG()]])dnl
]])
