# Generated by Django 3.1.1 on 2020-09-13 18:25

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('LabShare', '0009_auto_20200913_1805'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='dob',
            field=models.DateField(blank=True, default=datetime.datetime(2020, 9, 13, 18, 25, 26, 821988)),
        ),
    ]