import click
import json

from spotinst_sdk2 import SpotinstSession
from spotinst_sdk2.models.setup.azure import *


@click.group()
@click.pass_context
def cli(ctx, *args, **kwargs):
    ctx.obj = {}


@cli.command()
@click.argument('name', )
@click.option(
    '--token',
    required=False,
    help='Spotinst Token'
)
@click.pass_context
def create(ctx, *args, **kwargs):
    """Create a new Spot Account"""
    session = SpotinstSession(auth_token=kwargs.get('token'))
    ctx.obj['client'] = session.client("admin")
    result = ctx.obj['client'].create_account(kwargs.get('name'))
    click.echo(json.dumps(result))


@cli.command()
@click.argument('account-id')
@click.option(
    '--token',
    required=True,
    help='Spotinst Token'
)
@click.pass_context
def delete(ctx, *args, **kwargs):
    """Delete a Spot Account"""
    session = SpotinstSession(auth_token=kwargs.get('token'))
    ctx.obj['client'] = session.client("admin")
    ctx.obj['client'].delete_account(kwargs.get('account_id'))


@cli.command()
@click.argument('account-id')
@click.argument('client-id')
@click.argument('client-secret')
@click.argument('tenant-id')
@click.argument('subscription-id')
@click.option(
    '--token',
    required=True,
    help='Spotinst Token'
)
@click.pass_context
def set_cloud_credentials(ctx, **kwargs):
    """Set Azure credentials to Spot Account"""
    session = SpotinstSession(auth_token=kwargs.get('token'))
    ctx.obj['client2'] = session.client("setup_azure")
    ctx.obj['client2'].account_id = kwargs.get('account_id')
    azure_credentials = AzureCredentials(client_id=kwargs.get('client_id'), client_secret=kwargs.get('client_secret'),
                                         tenant_id=kwargs.get('tenant_id'),
                                         subscription_id=kwargs.get('subscription_id'))
    result = ctx.obj['client2'].set_credentials(azure_credentials)
    click.echo(json.dumps(result))


@cli.command()
@click.option(
    '--filter',
    required=False,
    help='Return matching records. Syntax: key=value'
)
@click.option(
    '--attr',
    required=False,
    help='Return only the raw value of a single attribute'
)
@click.option(
    '--token',
    required=True,
    help='Spotinst Token'
)
@click.pass_context
def get(ctx, *args, **kwargs):
    """Returns ONLY the first match"""
    session = SpotinstSession(auth_token=kwargs.get('token'))
    ctx.obj['client'] = session.client("admin")
    result = ctx.obj['client'].get_accounts()
    if kwargs.get('filter'):
        k, v = kwargs.get('filter').split('=')
        result = [x for x in result if x[k] == v]
    if kwargs.get('attr'):
        if result:
            result = result[0].get(kwargs.get('attr'))
            click.echo(result)
        else:
            fail_string = {'account_id': '', 'organization_id': ''}
            click.echo(json.dumps(fail_string))
    else:
        if result:
            click.echo(json.dumps(result[0]))
        else:
            fail_string = {'account_id': '', 'organization_id': ''}
            click.echo(json.dumps(fail_string))


if __name__ == "__main__":
    cli()