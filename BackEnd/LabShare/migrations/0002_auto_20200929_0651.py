# Generated by Django 3.1.1 on 2020-09-29 06:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('LabShare', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='dob',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
