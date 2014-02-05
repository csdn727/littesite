from django.conf.urls import patterns, include, url
from django.conf import settings
# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'littesite.views.home', name='home'),
    # url(r'^littesite/', include('littesite.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    
    url(r'^$', 'userinfo.views.login',name='home'),
    url(r'^logout$', 'userinfo.views.logout'),
    url(r'^sreg', 'userinfo.views.sreg'),
    url(r'^addT', 'userinfo.views.addT'),
    
    url(r'^classinfo', 'classinfo.views.cinfo'),
    url(r'^classList', 'classinfo.views.classList'),
    url(r'^newClass', 'classinfo.views.newClass'),   
    url(r'^classReg', 'classinfo.views.classReg'),
    url(r'^index_t', 'classinfo.views.index_t'),
    url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {
                    'document_root': settings.MEDIA_ROOT,
                }), 
)
