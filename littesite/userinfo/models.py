from django.db import models

# Create your models here.
class user_info(models.Model):
    userId = models.AutoField('userId', primary_key=True)
    userName = models.CharField('userName', max_length=50, unique=True)
    userPsd = models.CharField('userPsd', max_length=20)
    userType = models.IntegerField('userType')
    class Meta:
        db_table = 'user_info' 
    def is_authenticated(self):
        """
        Always return True. This is a way to tell if the user has been
        authenticated in templates.
        """
        return True    
    def __unicode__(self):
        return "%s" %self.userName