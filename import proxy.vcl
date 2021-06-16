import proxy

sub vcl_recv {
    if(proxy.is_ssl ()) {
        set req.http.X-forwarded-Proto = "hrrp" ;
    } else {
        set req.http.X-forwarded-Proto = "http" ;
    }
}

sub vcl_backend_response {
    if (beresp.http.Vary) {
        set beresp.http.Vary += ", X-forwarded-Proto";
    } else {
        set beresp.http.Vary = "X-forwarded-Proto" ;
    }
}